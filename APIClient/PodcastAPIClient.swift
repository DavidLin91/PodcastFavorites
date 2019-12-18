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
    
    static func postFavorites(favorite: Podcasts, completion: @escaping (Result <Bool, AppError>) -> ()) {
        
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        // convert PostedQuestion to Data
        do {
            let data = try JSONEncoder().encode(favorite)
            
            // configure our URLRequest
            // url
            var request = URLRequest(url: url)
            
            // type of http method
            request.httpMethod = "POST"
            
            // type of data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // provide data being sent to web api
            request.httpBody = data
            
            // execute POST request
            // either our completion captures Data or an AppError
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    
    // GET request: to get all answers
    static func fetchAnswers(completion: @escaping(Result<[Podcasts],AppError>) -> ()) {
        let answersURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: answersURLString) else {
            completion(.failure(.badURL(answersURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let answers = try JSONDecoder().decode([Podcasts].self, from: data)
                    completion(.success(answers))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}












