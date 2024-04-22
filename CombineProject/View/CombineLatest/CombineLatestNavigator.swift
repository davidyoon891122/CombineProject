//
//  CombineLatestNavigator.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import UIKit

protocol CombineLatestNavigatorProtocol: CommonNavigatorProtocol {
    
}

struct CombineLatestNavigator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
}

extension CombineLatestNavigator: CombineLatestNavigatorProtocol {
    
    func openView() {
        let vm = CombineLatestViewModel(navigator: self)
        let vc = CombineLatestViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


