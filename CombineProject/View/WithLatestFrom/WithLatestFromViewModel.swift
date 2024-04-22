//
//  WithLatestFromViewModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation
import Combine

struct WithLatestFromViewModel {
    
    struct Inputs {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Outputs {
        let title: AnyPublisher<String?, Never>
        let events: AnyPublisher<Void, Never>
    }
    
    private let navigator: WithLatestFromNavigatorProtocol
    
    init(navigator: WithLatestFromNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension WithLatestFromViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let titlePublisher = PassthroughSubject<String?, Never>()
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .handleEvents(receiveOutput: {
                    titlePublisher.send("WithLatestFrom")
                })
        )
        
        
        return .init(
            title: titlePublisher.eraseToAnyPublisher(),
            events: events.eraseToAnyPublisher()
        )
    }
    
}
