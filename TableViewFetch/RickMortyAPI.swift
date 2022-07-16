//
//  RickMortyAPI.swift
//  TableViewFetch
//
//  Created by Ömer Faruk Kılıçaslan on 16.07.2022.
//

import Foundation


final class RickMortyAPI {
    
    static let shared = RickMortyAPI()
    
    func fetchCharacterData(onCompletion: @escaping ([Characters]) -> () ) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{return}
            
            guard let characterList = try? JSONDecoder().decode(RickMorty.self, from: data) else{return}
            
            onCompletion(characterList.results)
            
        }
        .resume()
        
    }
}
