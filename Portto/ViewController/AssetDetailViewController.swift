//
//  AssetDetailViewController.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import UIKit
import Kingfisher

final class AssetDetailViewController: UIViewController {
    
    private enum Style {
        static let innerContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10)
        static let bottomContainerHeight: CGFloat = 50
        static let permaLinkButtonHeight: CGFloat = 40
        static let nameLabelFontSize: CGFloat = 20
        static let descriptionLabelFontSize: CGFloat = 15
    }
    
    private let viewModel: AssetDetailViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 0, left: 0, bottom: Style.bottomContainerHeight, right: 0)
        return scrollView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let innerContainerView: UIView = {
        let innerContainerView = UIView()
        return innerContainerView
    }()
    
    private let bottomContainer: UIView = {
        let bottomContainer = UIView()
        bottomContainer.backgroundColor = .clear
        return bottomContainer
    }()
    
    private let permaLinkButton: UIButton = {
        let permaLinkButton = UIButton()
        let title = NSLocalizedString("permaLinkButton", comment: "")
        permaLinkButton.backgroundColor = .black
        permaLinkButton.setTitle(title, for: .normal)
        return permaLinkButton
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: Style.nameLabelFontSize)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: Style.descriptionLabelFontSize)
        descriptionLabel.textAlignment = .center
        return descriptionLabel
    }()
    
    init(viewModel: AssetDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(bottomContainer)
        scrollView.addSubview(containerView)
        containerView.addSubview(innerContainerView)
        innerContainerView.addSubview(imageView)
        innerContainerView.addSubview(nameLabel)
        innerContainerView.addSubview(descriptionLabel)
        bottomContainer.addSubview(permaLinkButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomContainer.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(Style.bottomContainerHeight)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        
        innerContainerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(Style.innerContainerInset)
        }
        
        remakeImgeViewConstaints(ratio: 1)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        permaLinkButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(Style.permaLinkButtonHeight)
        }
        
        title = viewModel.collectionName
        navigationController?.navigationItem.backButtonTitle = ""
    }
    
    private func setupAction() {
        permaLinkButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
    }
    
    private func remakeImgeViewConstaints(ratio: CGFloat) {
        imageView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(ratio)
        }
    }
    
    private func bindViewModel() {
        imageView.kf.setImage(with: viewModel.imageUrl, completionHandler: { [weak self] result in
            guard case .success(let data) = result, let self = self else { return }
            let imageSize = data.image.size
            let ratio = imageSize.height / imageSize.width
            self.remakeImgeViewConstaints(ratio: ratio)
        })
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
    }
    
    
    @objc private func openLink() {
        guard let link = viewModel.permalinkURL else { return }
        UIApplication.shared.open(link)
    }
}
