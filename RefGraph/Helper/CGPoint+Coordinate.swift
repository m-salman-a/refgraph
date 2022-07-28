//
//  CGPoint+Coordinate.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 25/07/22.
//

import Foundation
import SwiftUI

extension CGPoint {
    static func fromCoordinate(coordinate: Vector2D) -> CGPoint {
        CGPoint(x: coordinate.x, y: coordinate.y)
    }
}
