//
//  RickMortyModel.swift
//  TableViewFetch
//
//  Created by Ömer Faruk Kılıçaslan on 16.07.2022.
//

import Foundation


struct RickMorty: Codable {
    
    let results: [Characters]
    
}

struct Characters: Codable {
    
    var id: Int
    var name: String
    var image: String
    
}
