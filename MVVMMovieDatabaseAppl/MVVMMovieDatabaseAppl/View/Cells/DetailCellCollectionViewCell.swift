//
//  DetailCellCollectionViewCell.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import UIKit

class DetailCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailCellCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        characterLabel.text = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.width  - 15,
                                      height: contentView.height / 2)
        characterLabel.frame = CGRect(x: 10,
                                       y: contentView.height / 2,
                                      width: contentView.width - 15,
                                      height: contentView.height / 2)
    }
    
    func configure(with viewModels: DetailViewModel) {
        characterLabel.text = viewModels.artist
        nameLabel.text = viewModels.name
    }
}
