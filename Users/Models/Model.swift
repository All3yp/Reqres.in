//
//  Model.swift
//  Users
//
//  Created by Alley Pereira on 16/07/21.
//

import Foundation

struct RequestModel: Decodable {
    let page: Int
    let data: [User]
}

struct User: Decodable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
