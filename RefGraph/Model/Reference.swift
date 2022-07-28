//
//  Reference.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 28/07/22.
//

import Foundation

struct Reference: Identifiable {
    
    let id = UUID()
    let title: String
    let url: URL?
    let description: String?
    let tags: [String]
    
}

extension Reference: Hashable { }
