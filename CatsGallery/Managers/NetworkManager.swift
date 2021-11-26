//
//  NetworkManager.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

class NetworkManager {
    
    let cache = NSCache<NSString, UIImage>()
    var urlsCurrentryUsedInDownloading = [URL]()
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.thecatapi.com/v1/images/search"
    
    private init() { }
    
    
    //MARK: - Fetching URL List from json
    func loadCatImageURLs(page: Int, completed: @escaping (Result<[URL], CTGError>) -> Void) {
        guard let endpointURL = URL(string: baseURL + "?limit=40&page=\(page)&order=DESC") else {
            completed(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: endpointURL) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let catURLs = try JSONDecoder().decode([Cat].self, from: data).map { $0.url }
                completed(.success(catURLs))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //MARK: - Download single image
    func loadImage(from url: URL, completed: @escaping (UIImage?) -> Void) {
        guard !urlsCurrentryUsedInDownloading.contains(url) else { return }
        
        if let image = self.cache.object(forKey: url.absoluteString as NSString) {
            completed(image)
        } else {
            urlsCurrentryUsedInDownloading.append(url)
            let task = URLSession.shared.downloadTask(with: url) { [weak self] location, response, error in
                guard let self = self else { return }
                self.urlsCurrentryUsedInDownloading = self.urlsCurrentryUsedInDownloading.filter { $0 != url }
                guard error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) else {
                        completed(nil)
                        return
                    }
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completed(image)
            }
            task.resume()
        }
    }
}


