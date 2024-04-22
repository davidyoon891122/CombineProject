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
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .gray
        
        return imageView
    }()
    
    private let separator = SeparatorView(separatorData: .init(color: .gray.withAlphaComponent(0.5)))
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel,
            self.arrowImageView,
            self.separator
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(self.arrowImageView.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.arrowImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        self.separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
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
    
    func setupCell(title: String) {
        self.titleLabel.text = title
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
