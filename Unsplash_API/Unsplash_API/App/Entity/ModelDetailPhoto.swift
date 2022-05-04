//
//  ModelDetailPhoto.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import Foundation

// MARK: - DetailPhoto
struct DetailPhoto: Codable {
    var id: String?
    var created_at: String?
    var urls: DetailUrls?
    var user: DetailUser?
    var location: DetailLocation?
    var downloads: Int?

}

// MARK: - Location
struct DetailLocation: Codable {
    var title: String?
}

// MARK: - Urls
struct DetailUrls: Codable {
    var raw, full, regular, thumb, small: String?
}

// MARK: - User
struct DetailUser: Codable {
    var username, name: String?
}
