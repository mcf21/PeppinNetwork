//
//  DataLoader.swift
//  
//
//  Created by Major League Digital on 16/8/21.
//

import Foundation

public struct DataLoader {
    public init() {}
    
    public func request<T: Decodable>(_ request: Request, decodable: T.Type, then handler: @escaping (Result<T,NetworkError>) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request.build()) { data, urlResponse, error in
            if let _ = error {
                handler(.failure(.cannotGetData))
            } else {
                if let data = data {
                    do {
                        let decodedData = try decoder(with: data, decoadable: decodable)
                        handler(.success(decodedData))
                    } catch {
                        handler(.failure(.cannotDecode))
                    }
                } else {
                    handler(.failure(.cannotGetData))
                }
            }
        }
        task.resume()
    }
    
    public func decoder<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder(), with data: Data, decoadable: T.Type) throws -> T {
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
