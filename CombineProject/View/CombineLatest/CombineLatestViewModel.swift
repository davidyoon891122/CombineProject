//
//  CombineLatestViewModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation
import Combine

struct CombineLatestViewModel {
    
    struct Inputs {
        let viewDidLoad: AnyPublisher<Void, Never>
        let numberButton: AnyPublisher<Int, Never>
        let stringButton: AnyPublisher<String, Never>
        let resetButton: AnyPublisher<Void, Never>
    }
    
    struct Outputs {
        let title: AnyPublisher<String?, Never>
        let displayValue: AnyPublisher<String?, Never>
        let events: AnyPublisher<Void, Never>
        let reset: AnyPublisher<Void, Never>
    }
    
    private let navigator: CombineLatestNavigatorProtocol
    
    init(navigator: CombineLatestNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CombineLatestViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let titlePublisher = PassthroughSubject<String?, Never>()
        let displayValuePublisher = PassthroughSubject<String?, Never>()
        let resetPublisher = PassthroughSubject<Void, Never>()
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .handleEvents(receiveOutput: {
                    titlePublisher.send("CombineLatest")
                })
                .map { _ in }
                .eraseToAnyPublisher()
            ,
            inputs.numberButton
                .combineLatest(inputs.stringButton) { ($0, $1) }
                .handleEvents(receiveOutput: { (number, string) in
                    displayValuePublisher.send("\(number) and \(string)")
                })
                .map { _ in }
                .eraseToAnyPublisher(),
            inputs.resetButton
                .handleEvents(receiveOutput: {
                    resetPublisher.send()
                })
                .map { _ in }
                .eraseToAnyPublisher()
        )
            .eraseToAnyPublisher()
        
        
        return .init(
            title: titlePublisher.eraseToAnyPublisher(),
            displayValue: displayValuePublisher.eraseToAnyPublisher(),
            events: events.eraseToAnyPublisher(),
            reset: resetPublisher.eraseToAnyPublisher()
        )
    }
    
}
