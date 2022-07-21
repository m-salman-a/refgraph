//
//  ReferenceGraph.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

// TODO: do something about the weight
class ReferenceGraph: Graphable {
    
    typealias Element = Reference
    
    var adjacencyDict: [Vertex<Element>: Set<Vertex<Element>>] = [:]
    
    func addVertex(_ vertex: Vertex<Reference>) {
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
    }
    
    func addEdge(from source: Vertex<Reference>, to destination: Vertex<Reference>, weight: Double) {
        addVertex(source)
        addVertex(destination)
        
        adjacencyDict[source]?.insert(destination)
        adjacencyDict[destination]?.insert(source)
    }
}
