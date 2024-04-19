//
//  MenuCollectionViewCell.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import UIKit
import SnapKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Title"
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
}

private extension MenuCollectionViewCell {
    
    func setupViews() {
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


#Preview {
    MenuCollectionViewCell()
}
