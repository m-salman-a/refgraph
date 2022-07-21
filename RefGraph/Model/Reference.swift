//
//  Reference.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 21/07/22.
//

import Foundation

struct Reference: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var link: URL
    var description: String
    
}
