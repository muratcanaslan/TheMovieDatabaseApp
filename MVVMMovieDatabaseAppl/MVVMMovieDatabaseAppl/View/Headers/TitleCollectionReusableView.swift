//
//  TitleCollectionReusableView.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: -20, width: width - 30, height: height + 40)
    }
    
    func configure(with title: String) {
        label.text = title
    }
    
}
