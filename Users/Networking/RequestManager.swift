//
//  RequestManager.swift
//  Users
//
//  Created by Alley Pereira on 16/07/21.
//

import Foundation

struct ServiceManager {
    let baseURl = URL(string: "https://reqres.in/api/users?page=1")
}

// MARK: - Generic request
extension ServiceManager {

    func request<T: Decodable>(_ request: URLRequest, decodeType: T.Type,
                               completion: @escaping (Result<T?, ServiceError>) -> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailure(description: error.localizedDescription)))
                return
            }

            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(.notFound))
                return
            }

            guard let data = data,
                  let decodedData: T = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.errorToParseURL))
                return
            }

            completion(.success(decodedData))
        }
        .resume()
    }

}


// MARK: - Errors API call
enum ServiceError: Error {
    case errorToParseURL
    case notFound
    case requestFailure(description: String)

    var localizedDescription: String {
        switch self {
        case .errorToParseURL:
            return "Error to parse URL"
        case .notFound:
            return "The Request returned status code 404, the route was not found."
        case .requestFailure(let description):
            return "Could not run request because: \(description)."
        }
    }
}
