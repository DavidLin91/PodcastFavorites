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
        
        
    }
    
    
    

}
