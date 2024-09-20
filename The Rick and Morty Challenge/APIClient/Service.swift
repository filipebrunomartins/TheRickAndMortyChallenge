//
//  Service.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/09/24.
//

import Foundation

/// Api service Rick and Morty data
final class Service {
    
    /// singletion instance
    static let shared = Service()
    
    /// contrutor privado
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// call Rick and Morty API
    /// - Parametros
    ///     -request
    ///     -tyoe (define o objeto de retorno)
    ///     -completion (callback)
    public func execute<T: Codable>(
        _ request: Request,
        expexting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else {
            return nil //Todo pq nao pode ser nill
        }
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
