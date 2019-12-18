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
        guard let podcast = podcastDetail else {
            return
        }
        let favorite = Podcasts(trackId: podcast.trackId, collectionId: podcast.collectionId, trackName: podcast.trackName, artistName: podcast.artistName, collectionName: podcast.collectionName, artworkUrl100: podcast.artworkUrl100, artworkUrl600: podcast.artworkUrl600, primaryGenreName: podcast.primaryGenreName, favoritedBy: "David")
        
        PodcastAPIClient.postFavorites(favorite: favorite) { (result) in
            DispatchQueue.main.async {
                sender.isEnabled = true
            }
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                self.showAlert(title: "Error posting question", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Success", message: "\(podcast.collectionName) was liked") { action in
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    
    
    
}
