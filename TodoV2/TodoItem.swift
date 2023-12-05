//
//  TodoItem.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 05/12/2023.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var name: String
    var priority: String
    
    init(name: String, priority: String) {
        self.name = name
        self.priority = priority
    }
}
