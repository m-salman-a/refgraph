//
//  Graph.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

protocol Graphable {
    associatedtype Element
    
    func addVertex(_ vertex: Vertex<Element>)
    func addEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double)
}

