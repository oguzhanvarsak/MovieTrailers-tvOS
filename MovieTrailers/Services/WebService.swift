//
//  WebService.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 4.06.2022.
//

import UIKit
import Foundation

protocol WebServiceProtocol {
    func parseJSON<T:Decodable>(from data: Data, to model: T.Type) -> Result<T, NetworkError>
    func getData<T:Decodable>(from url: String, for model: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func loadData(from url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

class WebService: WebServiceProtocol {
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    func getData<T:Decodable>(from url: String, for model: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let link = url.replacingOccurrences(of: " ", with: "")
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.noInternetConnection))
                } else {
                    if let data = data {
                        if let dataList = try? self.parseJSON(from: data, to: model.self).get() {
                            completion(.success(dataList))
                        }
                    }
                }
                
            }).resume()
        } else {
            completion(.failure(.badUrl(url)))
        }
    }
    
    func parseJSON<T:Decodable>(from data: Data, to model: T.Type) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(model.self, from: data)
            
            return .success(decodedData)
        } catch {
            print(error.localizedDescription)
            return .failure(.errorParsingJSON(error.localizedDescription))
        }
    }
    
    func loadData(from url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        utilityQueue.async {
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    completion(.success(data))
                } else {
                    completion(.failure(.dataReturnedNil))
                }
            } else {
                completion(.failure(.badUrl(url)))
            }
        }
    }
}
