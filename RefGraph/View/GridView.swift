//
//  GridView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 22/07/22.
//

import SwiftUI

struct GridView: View {
    
    @ObservedObject var viewModel =
    ReferenceGraphViewModel(
        repository: ReferencesRepository(dataStore: StaticReferencesDataStore()))
    @State private var vertexCursor: Vertex<Reference>?
    @State private var isEditing = false
    @State private var isShowingSheet = false
    @State private var isShowingInfo = false
    
    @State var portalPosition: CGPoint = .zero
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    
    func isSelected(vertex: Vertex<Reference>) -> Bool {
        return vertexCursor.map { cursor in
            cursor == vertex
        } ?? false || isShowingInfo
    }
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .trailing) {
                Text("RefGraph")
                    .font(.system(.largeTitle))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(.white)
                        
                    Group {
                        ForEach(viewModel.edges) { edge in
                            EdgeShape(start: .fromCoordinate(coordinate: edge.source.pos),
                                      end: .fromCoordinate(coordinate: edge.destination.pos))
                            .stroke(.black)
                            // TODO: set based on edge weight
                            .opacity(1)
                            .onTapGesture {
                                isShowingInfo.toggle()
                            }
                            .overlay(alignment: .center) {
//                                Text("""
//                                     \(viewModel.calculateIntersection(
//                                     from: edge.source,
//                                     to: edge.destination).joined(separator: ", "))
//                                     """)
//                                .offset(
//                                    x: (edge.destination.pos.x - edge.source.pos.x) / 2,
//                                    y: (edge.destination.pos.y - edge.source.pos.y) / 2)
//                                .opacity(isShowingInfo ? 1 : 0)
                            }
                        }
                        ForEach(viewModel.vertices) { vertex in
                            NodeView(
                                point: .fromCoordinate(coordinate: vertex.pos),
                                radius: 16,
                                isSelected: isSelected(vertex: vertex),
                                color:
                                viewModel.graph.adjacencyDict[vertex] == nil ||
                                viewModel.graph.adjacencyDict[vertex]?.isEmpty ?? false
                                    ? .red : .green
                            )
                            .onTapGesture {
                                if vertexCursor == nil {
                                    vertexCursor = vertex
                                } else {
                                    vertexCursor = nil
                                }
                            }
                            .shadow(radius: isSelected(vertex: vertex) ? 20 : 0)
                            .overlay(alignment: .center) {
                                Text(vertex.data.title)
                                    .offset(
                                        x: vertex.pos.x,
                                        y: vertex.pos.y - 50)
                                    .frame(width: 500, height: 20, alignment: .center)
                                    .opacity(isSelected(vertex: vertex) ? 1 : 0)
                                    .onTapGesture {
                                        if let url = vertex.data.url {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                        }
                    }.offset(
                        x: self.portalPosition.x + self.dragOffset.width,
                        y: self.portalPosition.y + self.dragOffset.height)
                    .animation(.linear(duration: 0.5))
                }.gesture(
                    DragGesture()
                    .onChanged { value in
                        self.processDragChange(value, containerSize: geo.size)
                    }
                    .onEnded { value in
                        self.processDragEnd(value)
                    }
                )
                
                HStack {
                    Button(action: {
                        isShowingInfo.toggle()
                    }) {
                        Text("i")
                            .frame(width: 64, height: 64, alignment: .center)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .background(.green)
                            .clipShape(Circle())
                    }.shadow(radius: 16)
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Text("+")
                            .frame(width: 64, height: 64, alignment: .center)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .background(.green)
                            .clipShape(Circle())
                    }.sheet(isPresented: $isShowingSheet) {
                        ReferenceFormView { ref in
                            let vertex = viewModel.addVertex(with: ref)
                            viewModel.addEdges(for: vertex)
                            
                            sortGraph(
                                screenHeight: Double(geo.size.height),
                                screenWidth: Double(geo.size.width))
                        }
                    }.shadow(radius: 16)
                }
            }
            .padding(.all)
            .onAppear {
                viewModel.getReferences()
                
                sortGraph(
                    screenHeight: Double(geo.size.height),
                    screenWidth: Double(geo.size.width))
                
            }
        }
    }
    
    func sortGraph(screenHeight: Double, screenWidth: Double) {
        withAnimation {
            viewModel.forceDirectReingold(
                L: screenHeight,
                W: screenWidth,
                iterations: 400)
            viewModel.forceCenter(
                position: Vector2D(x: screenWidth / 2, y: screenHeight / 2))
        }
    }
}


struct Previews_GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}

private extension GridView {
    
    // MARK: dragging the surface view
    
    func processDragChange(_ value: DragGesture.Value, containerSize: CGSize) {
        if !isDragging {
            isDragging = true
            dragOffset = value.translation
        }
    }
    
    func processDragEnd(_ value: DragGesture.Value) {
        isDragging = false
        dragOffset = .zero
        
        portalPosition = CGPoint(
            x: portalPosition.x + value.translation.width,
            y: portalPosition.y + value.translation.height)
    }
}

