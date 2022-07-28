//
//  GridView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 22/07/22.
//

import SwiftUI

class ReferenceGraphViewModel: ObservableObject {
    
    var graph: SomeGraph<Reference>
    var repository: ReferencesRepository
    
    @Published var vertices: [Vertex<Reference>]
    @Published var edges: [Edge<Reference>]
    
    init() {
        repository = ReferencesRepository(dataStore: DummyReferencesDataStore())
        graph = SomeGraph()
        
        vertices = []
        edges = []
    }
    
    func addVertex(with reference: Reference) {
        let vertex = Vertex(data: reference, position: Vector2D.random(maxX: 200, maxY: 600))
        graph.addVertex(vertex)
        vertices = graph.vertices
        
        vertices.forEach { other in
            guard vertex != other else { return }
            
            let weight: Double = vertex.data.tags.reduce(0) { acc, tag in
                other.data.tags.contains(tag.lowercased())
                ? acc + 1
                : acc
            }
            
            if weight > 0 { graph.addEdge(from: vertex, to: other, weight: weight) }
        }
        edges = graph.edges
    }
    
    
    func forceDirectReingold(W: Double, L: Double, iterations: Int) {
        let W = 500.0
        let L = 1000.0
        let area = W * L
        let V = Double(graph.vertices.count)
        let k = 0.5 * (area / V).squareRoot()
        
        func fa(_ x: Double) -> Double {
            x * x / k
        }
        
        func fr(_ x: Double) -> Double {
            k * k / x
        }
        
        for _ in 0..<iterations {
            // Calculate Repulsive Forces
            graph.vertices.forEach { v in
                v.vel = Vector2D.zero()
                
                graph.vertices.forEach { u in
                    if (u != v) {
                        /// Difference vector of positions
                        let diff = v.pos - u.pos
                        v.vel += (diff / diff.length()) * fr(diff.length())
                    }
                }
            }
            
            // Calculate Attractive Forces
            graph.edges.forEach { e in
                let diff = e.source.pos - e.destination.pos
                e.source.vel -= (diff / diff.length()) * fa(diff.length())
                e.destination.vel += (diff / diff.length()) * fa(diff.length())
            }
            
            // Move vertices
            graph.vertices.forEach { v in
                v.pos += v.vel / v.vel.length() * 0.975
                // Limit max. displacement
                v.pos.x = min(W / 2, max(-W / 2, v.pos.x))
                v.pos.y = min(L / 2, max(-L / 2, v.pos.y))
            }
            
            vertices = graph.vertices
        }
    }
    
    func forceCenter(position: Vector2D, strength: Double = 1) {
        let x = position.x
        let y = position.y
        let n = Double(graph.vertices.count)
        var sx = 0.0, sy = 0.0
        
        graph.vertices.forEach { vertex in
            sx += vertex.pos.x
            sy += vertex.pos.y
        }
        
        sx = (sx / n - x) * strength
        sy = (sy / n - y) * strength
        
        graph.vertices.forEach { vertex in
            vertex.pos.x -= sx
            vertex.pos.y -= sy
        }
        
        vertices = graph.vertices
    }
}

struct GridView: View {
    
    @ObservedObject var viewModel = ReferenceGraphViewModel()
    @State private var isShowingSheet = false
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    Color
                        .white
                        .ignoresSafeArea()
                    ForEach(viewModel.edges) { edge in
                        EdgeShape(start: .fromCoordinate(coordinate: edge.source.pos),
                                  end: .fromCoordinate(coordinate: edge.destination.pos))
                        .stroke(.black)
                    }
                    ForEach(viewModel.vertices) { vertex in
                        NodeView(point: .fromCoordinate(coordinate: vertex.pos), radius: 16)
                    }
                }
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    Text("+")
                        .frame(width: 44, height: 44, alignment: .center)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .background(.green)
                        .clipShape(Circle())
                }.sheet(isPresented: $isShowingSheet) {
                    FormView(viewModel: viewModel)
                }
            }
            .padding(.all)
            .onAppear {
                let screenHeight = Double(geo.size.height)
                let screenWidth = Double(geo.size.width)
                
                viewModel.repository.getReferences { references in
                    // Get vertices
                    references.forEach { ref in viewModel.addVertex(with: ref) }
                    
                    withAnimation {
                        viewModel.forceDirectReingold(
                            W: screenWidth,
                            L: screenHeight,
                            iterations: 500)
                        viewModel.forceCenter(
                            position: Vector2D(x: screenWidth / 2, y: screenHeight / 2))
                    }
                }
            }
        }
    }
}


struct Previews_GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
