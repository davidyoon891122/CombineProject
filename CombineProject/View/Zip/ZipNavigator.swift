//
//  ZipNavigator.swift
//  CombineProject
//
//  Created by Davidyoon on 4/23/24.
//

import UIKit

protocol ZipNavigatorProtocol: CommonNavigatorProtocol {
    
    
}

struct ZipNavigator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
}

extension ZipNavigator: ZipNavigatorProtocol {
    
    func openView() {
        let vm = ZipViewModel(navigator: self)
        let vc = ZipViewController(viewModel: vm)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
