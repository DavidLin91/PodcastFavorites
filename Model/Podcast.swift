//
//  Podcast.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import Foundation

struct AllPodcasts: Decodable {
    let results: [Podcasts]
}

struct Podcasts: Decodable {
    let trackId: Int
    let collectionId: Int?
    let trackName: String?
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let artworkUrl600: String
    let primaryGenreName: String?
    let favoritedBy: String?
    
}
