//
//  DummyReferencesDataStore.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 28/07/22.
//

import Foundation

class DummyReferencesDataStore: StaticReferencesDataStore {
    
   override init() {
       super.init()
       references = [
            Reference(title: "A", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "B", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "C", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "D", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "E", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "F", url: URL(string: ""), description: "", tags: ["tag"]),
            Reference(title: "G", url: URL(string: ""), description: "", tags: ["untag"])
        ]
    }

}
