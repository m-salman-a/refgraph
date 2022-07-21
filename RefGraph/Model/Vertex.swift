//
//  Node.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

struct Vertex<T> {
    
    var identifier: String
    var data: T
    
    init(data: T, identifier: String) {
        self.identifier = identifier
        self.data = data
    }
    
}

extension Vertex: Hashable {
    
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}
