//
//  ViewController.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class PodcastVC: UIViewController {
    @IBOutlet weak var podcastSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var podcasts = [Podcasts]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        podcastSearchBar.delegate = self
        searchPodcast(search: searchQuery)
        tableView.delegate = self
    }

    func searchPodcast(search: String) {
        PodcastAPIClient.getPodcasts(search: search) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self.podcasts = data
            }
        }
    }
    
    
    
    
    
    

}

extension PodcastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showsCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue to PodcastDVC")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(podcast: podcast)
        return cell
    }
}

extension PodcastVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchPodcast(search: searchText)
    }
}

extension PodcastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
