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
        let sut = SomeGraph<Reference>()
        
        XCTAssertEqual(sut.adjacencyDict.count, 0)
    }
    
    func whenAddVertex_ShouldAddVertexWithNoEdges() {
        let sut = SomeGraph<Reference>()
        let vertex = getVertex(title: "A")
        
        sut.addVertex(vertex)
        
        XCTAssertEqual(sut.adjacencyDict.count, 1)
        XCTAssertEqual(sut.adjacencyDict[vertex], [])
    }
    
    func whenAddEdge_ShouldAddEdgeWithCorrectSourceAndDestination() {
        let sut = SomeGraph<Reference>()
        let vertexA = getVertex(title: "A")
        let vertexB = getVertex(title: "B")
        
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        
        XCTAssertTrue(sut.adjacencyDict[vertexA]!.contains(vertexB))
        XCTAssertTrue(sut.adjacencyDict[vertexB]!.contains(vertexA))
    }
    
    func whenAddEdge_ShouldAddDestinationOnlyOnce() {
        let sut = SomeGraph<Reference>()
        let vertexA = getVertex(title: "A")
        let vertexB = getVertex(title: "B")
        
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        sut.addEdge(from: vertexA, to: vertexB, weight: 0)
        
        XCTAssertEqual(sut.adjacencyDict[vertexA]!.count, 1)
        XCTAssertEqual(sut.adjacencyDict[vertexB]!.count, 1)
    }
    
    // MARK: Helpers
    
    func getVertex(title: String) -> Vertex<Reference> {
        let reference = Reference(title: title, url: URL(string: ""), description: "", tags: [])
        let vertex = Vertex(data: reference)
        
        return vertex
    }
    
}
