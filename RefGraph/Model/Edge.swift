//
//  Edge.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 24/07/22.
//

import Foundation

class Edge<T>: Identifiable {
    
    var id = UUID()
    var source: Vertex<T>
    var destination: Vertex<T>
    var weight: Double
    
    init(source: Vertex<T>, destination: Vertex<T>, weight: Double) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }

}


extension Edge: Equatable where T: Equatable {
    static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        lhs.source == rhs.source &&
        lhs.destination == rhs.destination &&
        lhs.weight == rhs.weight
    }
}

extension Edge: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }
}
