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
        let didSelected: AnyPublisher<IndexPath, Never>
    }
    
    struct Outputs {
        let title: AnyPublisher<String?, Never>
        let menus: AnyPublisher<[MenuModel], Never>
        let events: AnyPublisher<Void, Never>
    }
    
    private let navigator: MenuNavigatorProtocol
    
    init(navigator: MenuNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension MenuViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let title: CurrentValueSubject<String?, Never> = .init("Menu")
        let menus: PassthroughSubject<[MenuModel], Never> = .init()
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .handleEvents(receiveOutput: { _ in
                    menus.send(MenuModel.menus)
                })
                .map { _ in }
                .eraseToAnyPublisher()
            ,
            inputs.didSelected
                .withLatestFrom(menus) { ($0, $1) }
                .handleEvents(receiveOutput: { result in
                    let menu = result.1[result.0.row]
                    navigator.toSelectedView(menuModel: menu)
                })
                .map { _ in }
                .eraseToAnyPublisher()
        )
            .eraseToAnyPublisher()
        
        return .init(
            title: title.eraseToAnyPublisher(),
            menus: menus.eraseToAnyPublisher(),
            events: events
        )
    }
    
}
