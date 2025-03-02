//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Toan Tran on 10/5/23.
//
//Update data.
import Foundation

struct Constants{
    static let API_KEY = ""
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = ""
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube"
}

enum APIError: Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)") else{
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else{
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc") else{
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            return
        }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?query=\(query)&api_key=\(Constants.API_KEY)") else{
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
        func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void){
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
                return
            }
            guard let url = URL(string:"\(Constants.YoutubeBaseURL)/v3/search?q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else{
                return
            }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
                
                guard let data = data, error == nil else{
                    return
                }
                do {
                    let result = try JSONDecoder().decode(YoutubeSearchResults.self, from: data)
                    
                    completion(.success(result.items[0]))
                   
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    
}
