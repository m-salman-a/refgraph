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
    var mainPoint: Bool
    
    var diameter: CGFloat {
        radius * 2
    }
    
    init(point: CGPoint, radius: CGFloat, stroke: Bool = true) {
        self.point = point
        self.radius = radius
        self.mainPoint = stroke
    }
    
    var body: some View {
        Circle()
            .stroke(.red, lineWidth: mainPoint ? 8 : 0)
            .foregroundColor(.white)
            .background(.white)
            .frame(width: diameter, height: diameter, alignment: .center)
        // Points indicate the center of circle
            .offset(x: point.x - radius, y: point.y - radius)
    }
}
