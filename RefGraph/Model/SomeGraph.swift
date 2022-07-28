//
//  ReferenceGraph.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

// TODO: add check to make sure edge source is always equal to key in dict
// TODO: needs refactor
class SomeGraph<T: Hashable>: Graphable {
    typealias Element = T
    
    var adjacencyDict: [Vertex<T>: Set<Vertex<T>>] = [:]
    
    var vertices: [Vertex<T>] {
        Array(adjacencyDict.keys)
    }
    
    var edges: [Edge<T>] {
        var arr = [Edge<T>]()
        for (source, neighbors) in adjacencyDict {
            for destination in Array(neighbors) {
                if !arr.contains(where: { edge in
                    destination == edge.source &&
                    source == edge.destination
                }) {
                    arr.append(Edge(source: source, destination: destination, weight: 0))
                }
            }
        }
        return arr
    }
    
    func addVertex(_ vertex: Vertex<T>) {
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
    }
    
    func addEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double) {
        addVertex(source)
        addVertex(destination)
        
        adjacencyDict[source]?.insert(destination)
        adjacencyDict[destination]?.insert(source)
    }
    
}
