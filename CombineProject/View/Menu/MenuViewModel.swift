//
//  MenuViewModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import Foundation
import Combine

struct MenuViewModel {
    
    struct Inputs {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Outputs {
        let menus: AnyPublisher<[MenuModel], Never>
        let events: AnyPublisher<Void, Never>
    }
    
}

extension MenuViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let menus: PassthroughSubject<[MenuModel], Never> = .init()
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .handleEvents(receiveOutput: { _ in
                    menus.send(MenuModel.menus)
                })
        )
            .eraseToAnyPublisher()
        
        return .init(
            menus: menus.eraseToAnyPublisher(),
            events: events
        )
    }
    
}
