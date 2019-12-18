//
//  PodcastDVC.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class PodcastDVC: UIViewController {
    
    var podcastDetail: Podcasts?
    
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        trackNameLabel.text = podcastDetail?.trackName
        artistName.text = podcastDetail?.artistName
        label.text = podcastDetail?.collectionName
        
        podcastImage.getImage(with: podcastDetail?.artworkUrl600 ?? "") { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.podcastImage.image = UIImage(systemName: "exclaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImage.image = image
                }
            }
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        guard let trackName = podcastDetail else {
            return
        }
        let favorite = Podcasts(trackId: trackName.trackId, collectionId: trackName.collectionId, trackName: trackName.trackName, artistName: trackName.artistName, collectionName: trackName.collectionName, artworkUrl100: trackName.artworkUrl100, artworkUrl600: trackName.artworkUrl600, primaryGenreName: trackName.primaryGenreName, favoritedBy: "David")
        
        
    
    
    
}
}
