//
//  FavoritePodcastVC.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class FavoritePodcastVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favoritePodcast: Podcasts?
    
    var favorites = [Podcasts]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchFavorites()
        title = "Favorites"
    }
    
    private func fetchFavorites() {
//        guard let favorite = favoritePodcast else {
//            fatalError("No favorites found")
//        }
        
        PodcastAPIClient.fetchFavorites { (result) in
            switch result {
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self.showAlert(title: "failed fetching favorites", message: "\(appError)")
                    }
                case .success(let favorite):
                    self.favorites = favorite.filter{$0.favoritedBy == "David"}
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastDVC = segue.destination as? PodcastDVC,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("could not dequeue to PodcastDVC")
        }
        let podcast = favorites[indexPath.row]
        podcastDVC.podcastDetail = podcast
    }
    
    
    
}

extension FavoritePodcastVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritePodcastCell else {
            fatalError("cannot dequeue FavoritePodcastCell")
        }
        let favorite = favorites[indexPath.row]
        cell.configureCell(podcast: favorite)
        return cell
    }
}


extension FavoritePodcastVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
