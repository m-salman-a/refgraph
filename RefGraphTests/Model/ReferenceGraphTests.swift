//
//  ReferenceGraphTests.swift
//  RefGraphTests
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

@testable import RefGraph
import XCTest

class ReferenceGraphTest: XCTestCase {
    
    func whenFirstInit_ShouldHaveNoVertices() {
        let sut = ReferenceGraph()
        
        XCTAssertEqual(sut.adjacencyDict.count, 0)
    }
    
    func whenAddVertex_ShouldAddVertexWithNoAdjacency() {
        let sut = ReferenceGraph()
        let vertex = getVertex(name: "A")
        
        sut.addVertex(vertex)
        
        XCTAssertEqual(sut.adjacencyDict.count, 1)
        XCTAssertEqual(sut.adjacencyDict[vertex], [])
    }
    
    func whenAddEdge_ShouldAddToDictOnSourceAndDestination() {
        let sut = ReferenceGraph()
        let vertexA = getVertex(name: "A")
        let vertexB = getVertex(name: "B")
        
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        
        XCTAssertTrue(sut.adjacencyDict[vertexA]!.contains(vertexB))
        XCTAssertTrue(sut.adjacencyDict[vertexB]!.contains(vertexA))
    }
    
    func whenAddEdge_ShouldAddDestinationOnlyOnce() {
        let sut = ReferenceGraph()
        let vertexA = getVertex(name: "A")
        let vertexB = getVertex(name: "B")
        
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        
        XCTAssertEqual(sut.adjacencyDict[vertexA]!.count, 1)
        XCTAssertEqual(sut.adjacencyDict[vertexB]!.count, 1)
    }
    
    // MARK: Helpers
    
    func getVertex(name: String) -> Vertex<Reference> {
        let reference = Reference(name: name, link: URL(string: "")!, description: "")
        let vertex = Vertex(data: reference, identifier: reference.name)
        
        return vertex
    }
    
}
