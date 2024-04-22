//
//  CombineLatestViewModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation

struct CombineLatestViewModel {
    
    struct Inputs {
        
    }
    
    struct Outputs {
        
    }
    
    private let navigator: CombineLatestNavigatorProtocol
    
    init(navigator: CombineLatestNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CombineLatestViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        return .init()
    }
    
}
