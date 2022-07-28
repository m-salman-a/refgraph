//
//  StaticReferencesDataStore.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 28/07/22.
//

import Foundation

class StaticReferencesDataStore: ReferencesDataStore {
    var references = [
        Reference(
            title: "Advanced SwiftUI Animations",
            url: URL(string: "https://swiftui-lab.com/swiftui-animations-part3/"),
            description: "",
            tags: ["SwiftUI", "Animation", "AnimatableView"]),
        Reference(
            title: "The magic of Animatable values in SwiftUI",
            url: URL(string: "https://swiftwithmajid.com/2020/06/17/the-magic-of-animatable-values-in-swiftui/"),
            description: "",
            tags: ["SwiftUI", "Animation"]),
        Reference(
            title: "Generic TableView Cells and Sections in Swift",
            url: URL(string: "https://medium.com/swift-gurus/generic-tableview-cells-and-sections-69c8ae241636"),
            description: "",
            tags: ["UIKit", "TableView", "Generic", "Clean code"]),
    ]
    
    func getReferences(_ callback: (@escaping ([Reference]) -> Void)) {
        callback(references)
    }
    
    func addReference(_ reference: Reference) {
        references.append(reference)
    }
    
    func updateReference(_ id: UUID, _ reference: Reference) {
        if let index = references.firstIndex(where: { ref in ref.id == id }) {
            references[index] = reference
        }
    }
    
    func removeReference(_ id: UUID) {
        references.removeAll { ref in
            ref.id == id
        }
    }
    
}


