//
//  MenuModel.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import Foundation

struct MenuModel: Identifiable {
    
    let id = UUID()
    let title: String
    
}

extension MenuModel: Hashable { }


extension MenuModel {
    
    static let menus: [Self] = [
        .init(title: "withLatestFrom")
    ]
    
}
