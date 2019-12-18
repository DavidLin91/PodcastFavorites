//
//  FavoritePodcastCell.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/18/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class FavoritePodcastCell: UITableViewCell {
    
    
    @IBOutlet weak var favoriteImageCell: UIImageView!
    @IBOutlet weak var favoritePodcastName: UILabel!
    @IBOutlet weak var favoritePrimaryGenre: UILabel!
    
    
    func configureCell(podcast: Podcasts) {
        favoritePodcastName.text = podcast.artistName
        favoritePrimaryGenre.text = podcast.primaryGenreName
        
        favoriteImageCell.getImage(with: podcast.artworkUrl600) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.favoriteImageCell.image = image
                }
            }
        }
    }
}
