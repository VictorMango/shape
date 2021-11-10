//
//  TMDbClient.swift
//  API
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation
import Client
import Entities

public final class TMDbClient: LoggingClient {
    private let authorizationParameters: RequestParameters

    public init(apiKey: String) {
        self.authorizationParameters = QueryParameters([.init(name: "api_key", value: apiKey)])
        super.init(baseURL: "https://api.themoviedb.org/3")
        defaultHeaders["Content-Type"] = "application/json"
    }

    public override func prepare<T, E>(request: Request<T, E>) -> Request<T, E> {
        var request = request
        if request.needsAuthorization {
            request.parameters.append(authorizationParameters)
        }
        return request
    }
}
