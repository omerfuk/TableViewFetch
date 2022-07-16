//
//  FeedCell.swift
//  TableViewFetch
//
//  Created by Ömer Faruk Kılıçaslan on 16.07.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    static let identifier = "FeedCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
        
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        
        return label
            
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 2, y: 2, width: 150, height: 100)
        myLabel.frame = CGRect(x: 155, y: 30, width: contentView.frame.size.width - 160, height: 50)
        print(contentView.frame.size.height / 2)
    }
    
    
    func configureImageView(with imageURL: String){
        contentView.addSubview(myImageView)
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 20.0
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        myImageView.downloaded(from: imageURL)
    }
    
    func configureLabel(with label:String){
        contentView.addSubview(myLabel)
        myLabel.font = UIFont.systemFont(ofSize: 15)
        myLabel.textColor = .red
        myLabel.numberOfLines = 2
        myLabel.text = label
    }
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        
        downloaded(from: url, contentMode: mode)
    }
}
