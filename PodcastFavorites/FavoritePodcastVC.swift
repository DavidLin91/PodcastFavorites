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
