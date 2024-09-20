//
//  Request.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/09/24.
//

import Foundation

/// API call
final class Request {
    
    // Constants API
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    //Endpoint
    private let endpoint: Endpoint
    
    // Path se tiver
    private let pathComponents: [String]
    
    // Param se tiver
    private let queryParameters: [URLQueryItem]
    
    // Construir URL api request String format
    private var urlStrting: String {
        var string = Constants.baseUrl
        
        // Adiciona caminho da chamada
        string += "/"
        string += endpoint.rawValue
        
        // Monta path se tiver
        if !pathComponents.isEmpty {
            string += "/"
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        // Monta param se tiver
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        // Retorna URL string
        return string
    }
    
    // Converte URL string em URL
    public var url: URL? {
        return URL(string: urlStrting)
    }
    
    public let httpMethod = "GET"
    
    // Contructor request
    init(
        endpoint: Endpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension Request {
    static let listCharactersRequest = Request(endpoint: .character)
}
