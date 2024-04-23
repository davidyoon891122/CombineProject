//
//  MenuNavigator.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import UIKit

protocol CommonNavigatorProtocol {
    func openView()
}

protocol MenuNavigatorProtocol: CommonNavigatorProtocol {
    
    func toSelectedView(menuModel: MenuModel)
    
}

struct MenuNavigator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension MenuNavigator: MenuNavigatorProtocol {
    
    func openView() {
        let vc = MenuViewController(viewModel: MenuViewModel(navigator: self))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func toSelectedView(menuModel: MenuModel) {
        switch menuModel.type {
        case .withLatestFrom:
            let navigator = WithLatestFromNavigator(navigationController: self.navigationController)
            navigator.openView()
        case .combineLatest:
            let navigator = CombineLatestNavigator(navigationController: self.navigationController)
            navigator.openView()
        case .zip:
            let navigator = ZipNavigator(navigationController: self.navigationController)
            navigator.openView()
        }
    }
    
}
