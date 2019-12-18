//
//  PodcastCell.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var trackThumbnailImage: UIImageView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var podcastGenre: UILabel!
    
    
    func configureCell(podcast: Podcasts) {
        podcastName.text = podcast.collectionName
        podcastGenre.text = podcast.primaryGenreName
        
        trackThumbnailImage.getImage(with: podcast.artworkUrl100) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.trackThumbnailImage.image = UIImage(systemName: "exclaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.trackThumbnailImage.image = image
                }
            }
        }
    }
    
}
