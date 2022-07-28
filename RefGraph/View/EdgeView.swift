//
//  EdgeView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation
import SwiftUI

struct EdgeView: View {
    
    var start: CGPoint
    var end: CGPoint
    var animatableData: AnimatablePair<AnimatablePair<CGFloat, CGFloat>, AnimatablePair<CGFloat, CGFloat>> {
        get { AnimatablePair(AnimatablePair(start.x, start.y), AnimatablePair(end.x, end.y)) }
        set {
            start = CGPoint(x: newValue.first.first, y: newValue.first.second)
            end = CGPoint(x: newValue.second.first, y: newValue.second.second)
        }
    }
    
    var body: some View {
        EdgeShape(start: start, end: end)
            .fill(.red)
            .frame(width: 100, height: 100, alignment: .center)
            .border(.red, width: 16)
    }
}

struct EdgeShape: Shape {
    
    var start: CGPoint
    var end: CGPoint
    var animatableData: AnimatablePair<AnimatablePair<CGFloat, CGFloat>, AnimatablePair<CGFloat, CGFloat>> {
        get { AnimatablePair(AnimatablePair(start.x, start.y), AnimatablePair(end.x, end.y)) }
        set {
            start = CGPoint(x: newValue.first.first, y: newValue.first.second)
            end = CGPoint(x: newValue.second.first, y: newValue.second.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: start)
        path.addLine(to: end)
        
        return path
    }
    
}
