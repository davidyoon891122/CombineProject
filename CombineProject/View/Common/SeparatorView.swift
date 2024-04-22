//
//  SeparatorView.swift
//  PWM
//
//  Created by Davidyoon on 4/5/24.
//

import UIKit
import SnapKit

enum SeparatorDirection {
    case horizontal
    case vertical
}

final class SeparatorView: UIView {
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let separatorData: SeparatorData
    
    init(separatorData: SeparatorData) {
        self.separatorData = separatorData
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SeparatorView {
    
    func setupViews() {
        addSubview(separator)
        
        separator.backgroundColor = self.separatorData.color
        
        switch self.separatorData.direction {
        case .vertical:
            separator.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalTo(self.separatorData.size)
            }
        case .horizontal:
            separator.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(self.separatorData.size)
            }
        }
    }
    
}

#Preview {
    SeparatorView(separatorData: .init())
}

struct SeparatorData {
    
    let direction: SeparatorDirection
    let size: CGFloat 
    let color: UIColor
    
    init(
        direction: SeparatorDirection = .horizontal,
        size: CGFloat = 1.0,
        color: UIColor = .gray
    ) {
        self.direction = direction
        self.size = size
        self.color = color
    }
    
}

