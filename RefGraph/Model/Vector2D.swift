//
//  Coordinate.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 24/07/22.
//

import Foundation

struct Vector2D: Equatable {
    var x: Double
    var y: Double
    
    static func zero() -> Vector2D {
        Vector2D(x: 0, y: 0)
    }
    
    static func random(maxX: Double, maxY: Double) -> Vector2D {
        let x = Double.random(in: 0..<maxX)
        let y = Double.random(in: 0..<maxY)
        return Vector2D(x: x, y: y)
    }
    
    static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        return Vector2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func * (lhs: Vector2D, rhs: Double) -> Vector2D {
        return Vector2D(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func / (lhs: Vector2D, rhs: Double) -> Vector2D {
        return Vector2D(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    static func -= (left: inout Vector2D, right: Vector2D) {
        left = left - right
    }
    
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
    
    func length() -> Double {
        (pow(self.x, 2) + pow(self.y, 2)).squareRoot()
    }
    
    func euclideanDistance(other: Vector2D) -> Double {
        (pow(self.x - other.x, 2) + pow(self.y - other.y, 2)).squareRoot()
    }
    
    func unitVector(other: Vector2D) -> Vector2D {
        var unit = self - other
        unit = unit / unit.length()
        return unit
    }
    
}

extension Vector2D: Comparable {
    static func < (lhs: Vector2D, rhs: Vector2D) -> Bool {
        return lhs.length() < rhs.length()
    }
}
