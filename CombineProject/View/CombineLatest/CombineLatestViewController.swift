//
//  CombineLatestViewController.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit

final class CombineLatestViewController: UIViewController {
    
    private let viewModel: CombineLatestViewModel
    
    init(viewModel: CombineLatestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

private extension CombineLatestViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        
    }
    
}

#Preview {
    CombineLatestViewController(viewModel: CombineLatestViewModel(navigator: CombineLatestNavigator(navigationController: nil)))
}
