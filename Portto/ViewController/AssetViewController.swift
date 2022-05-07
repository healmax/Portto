//
//  HomeViewController.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import UIKit
import Moya
import SnapKit
import RxSwift

final class AssetViewController: UIViewController {
    
    var didSelectedAsset: ((Asset) -> Void)?
    
    private let disposeBag = DisposeBag()
    private let viewModel = AssetViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = AssetViewCell.Style.sectionEdgeInsets
        layout.minimumInteritemSpacing = AssetViewCell.Style.interitemSpacing
        layout.itemSize = AssetViewCell.Style.cellSize
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: AssetViewCell.self)
        
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.collectionView = collectionView
        self.title = NSLocalizedString("List", comment: "")
    }
    
    private func bindViewModel() {
        viewModel.reload()
        viewModel.assetsObservable
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom(offset: 10)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.loadNextPage()
            })
            .disposed(by: disposeBag)
    }
}

extension AssetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.assetsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = viewModel.retriveAsset(by: indexPath.row)
        let cell = collectionView.dequeueReusableCell(with: AssetViewCell.self, for: indexPath)
        cell.bindModel(asset: asset)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = viewModel.retriveAsset(by: indexPath.row)
        didSelectedAsset?(asset)
    }
}

