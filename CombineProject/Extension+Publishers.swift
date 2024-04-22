//
//  Extension+Publishers.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation
import Combine

extension Publisher where Output == Void, Self.Failure == Never {
    
    func sinkIgnored() -> AnyCancellable {
        sink {
            _ in
        }
    }
    
}

