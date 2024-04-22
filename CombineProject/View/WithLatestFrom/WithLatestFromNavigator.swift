//
//  WithLatestFromNavigator.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import UIKit

protocol WithLatestFromNavigatorProtocol: CommonNavigatorProtocol {
    
}

struct WithLatestFromNavigator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
}

extension WithLatestFromNavigator: WithLatestFromNavigatorProtocol {
    
    func openView() {
        let vm = WithLatestFromViewModel(navigator: self)
        let vc = WithLatestFromViewController(viewModel: vm)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
