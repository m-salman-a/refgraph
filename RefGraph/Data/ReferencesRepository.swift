//
//  ReferencesRepository.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 28/07/22.
//

import Foundation

class ReferencesRepository {
    
    let dataStore: ReferencesDataStore
    
    init(dataStore: ReferencesDataStore) {
        self.dataStore = dataStore
    }
    
    func getReferences(_ callback: @escaping (([Reference]) -> Void)) {
        dataStore.getReferences(callback)
    }
    
}
