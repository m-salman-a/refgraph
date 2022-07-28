//
//  ReferencesDataStore.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 28/07/22.
//

import Foundation

protocol ReferencesDataStore {
    func getReferences(_ callback: @escaping (([Reference]) -> Void))
    func addReference(_ reference: Reference)
    func updateReference(_ id: UUID, _ reference: Reference)
    func removeReference(_ id: UUID)
}
