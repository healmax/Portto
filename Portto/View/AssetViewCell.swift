//
//  HomeViewCell.swift
//  Portto
//
//  Created by Vincent on 2022/5/6.
//

import UIKit
import Kingfisher

final class AssetViewCell: UICollectionViewCell {
    
    enum Style {
        static let rowItemCount = 2
        static let sectionEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let interitemSpacing: CGFloat = 10
        static let edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let imageSize = CGSize.init(width: width, height: width)
        static let cellSize = CGSize.init(width: width, height: height)
        static let height: CGFloat = width * 1.4
        static let width: CGFloat = (UIScreen.main.bounds.width
                                     - sectionEdgeInsets.left
                                     - sectionEdgeInsets.right
                                     - interitemSpacing)/CGFloat(rowItemCount)
        static let nameLabelTopConstraint = 10.0
    }
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds =  true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func bindModel(asset: Asset) {
        imageView.kf.setImage(with: URL(string: asset.imageUrl))
        nameLabel.text = asset.name
    }
    
    //MARK: Private Funcation
    private func setupUI() {
        backgroundColor = .blue
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Style.edgeInset)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Style.nameLabelTopConstraint)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
