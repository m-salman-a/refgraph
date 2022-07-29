//
//  NodeView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 22/07/22.
//

import SwiftUI

struct NodeView: View {
    
    var point: CGPoint
    var radius: CGFloat
    var isSelected: Bool
    var color: Color
    
    var diameter: CGFloat {
        radius * 2
    }
    
    init(point: CGPoint, radius: CGFloat, isSelected: Bool = true, color: Color) {
        self.point = point
        self.radius = radius
        self.isSelected = isSelected
        self.color = color
    }
    
    var body: some View {
        Circle()
            .stroke(.white, lineWidth: isSelected ? 4 : 0)
            .foregroundColor(color)
            .background(color)
            .frame(width: diameter, height: diameter, alignment: .center)
            .clipShape(Circle())
        // Points indicate the center of circle
            .offset(x: point.x - radius, y: point.y - radius)
    }
}
