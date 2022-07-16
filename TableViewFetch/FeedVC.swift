//
//  ViewController.swift
//  TableViewFetch
//
//  Created by Ömer Faruk Kılıçaslan on 16.07.2022.
//

import UIKit

class FeedVC: UIViewController {

    var characters: [Characters] = []
    
    private let tableView: UITableView = {
       
        let tableView = UITableView()
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchCharacterData()
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchCharacterData() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{return}
            
            guard let characterList = try? JSONDecoder().decode(RickMorty.self, from: data) else{return}
            
            DispatchQueue.main.async {
                self.characters = characterList.results
                self.tableView.reloadData()
            }
            
        }
        .resume()
        
    }


}

extension FeedVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        print(characters[indexPath.row].image)
        cell.configureImageView(with: characters[indexPath.row].image)
        cell.configureLabel(with: characters[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

}


