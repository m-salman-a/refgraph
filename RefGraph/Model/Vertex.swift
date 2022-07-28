//
//  Node.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

class Vertex<T>: Identifiable {
    
    var id = UUID()
    var data: T
    var pos: Vector2D
    var vel: Vector2D
    
    init(data: T) {
        self.data = data
        self.pos = Vector2D.zero()
        self.vel = Vector2D.zero()
    }
    
    init(data: T, position: Vector2D) {
        self.data = data
        self.pos = position
        self.vel = Vector2D.zero()
    }
    
    init(data: T, position: Vector2D, velocity: Vector2D) {
        self.data = data
        self.pos = position
        self.vel = velocity
    }
}

extension Vertex: Equatable where T: Equatable {
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        lhs.data == rhs.data
    }
}

extension Vertex: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
}
