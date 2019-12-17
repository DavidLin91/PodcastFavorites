//
//  PodcastAPIClient.swift
//  PodcastFavorites
//
//  Created by David Lin on 12/17/19.
//  Copyright © 2019 David Lin (Passion Proj). All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcasts(search: String, completion: @escaping(Result<[Podcasts], AppError>)-> ()) {
        
        
        let search = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "swift"
        
        let endpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(search)"
        
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        var podcast = [Podcasts]()
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let podcastData = try JSONDecoder().decode(AllPodcasts.self, from: data)
                    podcast = podcastData.results
                    completion(.success(podcast))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
