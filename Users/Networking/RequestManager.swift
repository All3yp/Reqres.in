//
//  RequestManager.swift
//  Users
//
//  Created by Alley Pereira on 16/07/21.
//

import Foundation

struct ServiceManager {

    func getUsers(page: Int) -> URL {

        return URL(string: "https://reqres.in/api/users?page=\(page)")!
    }
}

// MARK: - Generic request
extension ServiceManager {

    func request<T: Decodable>(_ request: URLRequest,
                               decodeType: T.Type,
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

            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }

            do {
                let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch {
                print(error)
                completion(.failure(.errorOnDecode))
                return
            }

        }
        .resume()
    }


    // MARK: - Errors API call
    enum ServiceError: Error {
        case dataIsNil
        case errorOnDecode
        case notFound
        case requestFailure(description: String)

        var localizedDescription: String {
            switch self {
            case .dataIsNil:
                return "Data returned nil from request"
            case .errorOnDecode:
                return "Error decoding request result data"
            case .notFound:
                return "The Request returned status code 404, the route was not found."
            case .requestFailure(let description):
                return "Could not run request because: \(description)."
            }
        }
    }
}
