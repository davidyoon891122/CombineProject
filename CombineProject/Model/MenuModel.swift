//
//  MenuModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation

enum MenuType: CaseIterable {
    
    case withLatestFrom
    case combineLatest
    
    var title: String {
        switch self {
        case .withLatestFrom:
            return "WithLatestFrom"
        case .combineLatest:
            return "CombineLatest"
        }
    }
    
}

struct MenuModel: Identifiable {
    
    let id = UUID()
    let title: String
    let type: MenuType
    
}

extension MenuModel: Hashable { }


extension MenuModel {
    
    static let menus: [Self] = MenuType.allCases.map {
        .init(title: $0.title, type: $0)
    }
    
}
