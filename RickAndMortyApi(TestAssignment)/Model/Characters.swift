//
//  Characters.swift
//  RickAndMortyApi(TestAssignment)
//
//  Created by Alexey on 11/15/22.
//

import Foundation

struct Characters: Decodable {
    
    let name: String?
    let species: String?
    let gender: String?
    let image: String?
    let status: String?
    let origin: Origin
    
}

struct Origin: Decodable {
    
    let name: String?
    let url: String?
    
}

struct Result: Decodable {
    let results: [Characters]
}



