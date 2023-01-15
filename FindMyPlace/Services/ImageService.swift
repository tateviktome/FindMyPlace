//
//  ImageService.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import UIKit
import Combine

protocol ImageServiceProtocol {
    func loadImage(with url: String) -> AnyPublisher<Resolvable<UIImage>, Never>
}

final class ImageService: ImageServiceProtocol {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        return session
    }()
    
    private let imageCache = NSCache<NSString, UIImage>()

    private var urlToPublisher = [String: AnyPublisher<Resolvable<UIImage>, Never>]()

    func loadImage(with url: String) -> AnyPublisher<Resolvable<UIImage>, Never> {
        let cacheKey = url as NSString
        if let image = imageCache.object(forKey: cacheKey) {
            return Just(.success(image)).eraseToAnyPublisher()
        }
        guard let url = URL(string: url) else {
            return Just(.failure(NetworkError.invalidRequest(description: "Something went wrong"))).eraseToAnyPublisher()
        }
        if let existing = urlToPublisher[cacheKey as String] {
            return existing
        }
        let request = URLRequest(url: url)
        let publisher =
            session
                .dataTaskPublisher(for: request)
                .tryMap { result -> (UIImage, Int) in
                    guard let image = UIImage(data: result.data) else {
                        throw NetworkError.invalidResponse
                    }
                    return (image, result.data.count)
                }
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveOutput: { [weak self] (image, cost) in
                    self?.imageCache.setObject(image, forKey: cacheKey, cost: cost)
                }, receiveCompletion: { [weak self] _ in
                    self?.urlToPublisher.removeValue(forKey: cacheKey as String)
                })
                .map { $0.0 }
                .asResolvable()
                .share()
                .eraseToAnyPublisher()
        urlToPublisher[cacheKey as String] = publisher
        return publisher
    }
}
