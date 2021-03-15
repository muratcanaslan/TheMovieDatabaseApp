//
//  TopRatedCollectionViewCell.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 11.03.2021.
//

import UIKit
import Kingfisher

class TopRatedCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopRatedCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .ultraLight)
        label.numberOfLines = 0

        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .ultraLight)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height - 10
        let nameLabelSize = nameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10,
                                                          height: contentView.height - 10))
        let nameLabelHeight = min(60, nameLabelSize.height)
        nameLabel.sizeToFit()
        ratingLabel.sizeToFit()
        
        imageView.frame = CGRect(x: 5,
                                 y: 5,
                                 width: imageSize,
                                 height: imageSize)
        
        nameLabel.frame = CGRect(x: imageView.right + 10,
                                 y: 5,
                                 width: nameLabelSize.width,
                                 height: nameLabelHeight)
        
        dateLabel.frame = CGRect(x: imageView.right + 10,
                                 y: nameLabel.bottom,
                                 width: contentView.width - imageView.right - 10,
                                 height: 30)
        
       
        
        ratingLabel.frame = CGRect(x: imageView.right + 10,
                                   y: contentView.bottom - 44,
                                   width: ratingLabel.width + 50,
                                   height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
        ratingLabel.text = nil
    }
    
    func configure(with viewModel: TopRatedCellViewModel) {
        ratingLabel.text = "IMDB: \(viewModel.rating)"
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        imageView.kf.setImage(with: viewModel.artworkURL)
    }
}
