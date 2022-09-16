//
//  SearchResults.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import Foundation

struct SearchResults: Codable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable {
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue: String]
    let created_at: String
    let user: User
    
    enum URLKind: String {
        case raw
        case full
        case regulsr
        case small
        case thumb
    }
}

struct User: Codable {
    let username: String
    let name: String
}
