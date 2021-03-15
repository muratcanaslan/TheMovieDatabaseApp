//
//  PopularCollectionViewCell.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    
    private let popularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(popularImageView)
        contentView.layer.cornerRadius = 8
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height - 70
        
        titleLabel.frame = CGRect(x: 3,
                                  y: contentView.height - 60,
                                  width: contentView.width - 6,
                                  height: 30)
        
        rateLabel.frame = CGRect(x: 3,
                                 y: contentView.height - 30,
                                 width: contentView.width - 6,
                                 height: 30)
        
        popularImageView.frame = CGRect(x: (contentView.width - imageSize) / 2,
                                        y: 3,
                                        width: imageSize,
                                        height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        popularImageView.image = nil
        rateLabel.text = nil
        titleLabel.text = nil
    }
    
    func configure(with viewModel: PopularCellViewModel ) {
        popularImageView.kf.setImage(with: viewModel.artworkURL)
        rateLabel.text = "IMDB: \(viewModel.rate)"
        titleLabel.text = viewModel.title
    }
}
