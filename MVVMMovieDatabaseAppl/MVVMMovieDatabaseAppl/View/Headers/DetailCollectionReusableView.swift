//
//  DetailCollectionReusableView.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import UIKit


class DetailCollectionReusableView: UICollectionReusableView {
    static let identifier = "DetailCollectionReusableView"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.backgroundColor = UIColor.init(rgb: 0x03045e)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 30
        label.layer.masksToBounds = true
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  .secondarySystemBackground
        addSubview(nameLabel)
        addSubview(overviewLabel)
        addSubview(dateLabel)
        addSubview(ratingLabel)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height / 1.8
        imageView.frame = CGRect(x: (width - imageSize) / 2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width - 20, height: 44)
        overviewLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width - 20, height: 90)
        dateLabel.frame = CGRect(x: 10, y: overviewLabel.bottom, width: width - 20, height: 44)
        ratingLabel.frame = CGRect(x: width - 80, y: height - 30, width: 60, height: 60)
    }
    
    func configure(with viewModel: MovieDetailCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
        overviewLabel.text = viewModel.overview
        dateLabel.text = viewModel.date
        ratingLabel.text = String(viewModel.rating ?? 0.0)
        imageView.kf.setImage(with: viewModel.artworkURL)
    }
}
