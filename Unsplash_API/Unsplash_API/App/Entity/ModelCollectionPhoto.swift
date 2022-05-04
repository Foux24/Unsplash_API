//
//  ModelCollectionPhoto.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import Foundation

// MARK: - SearchCollectionPhoto
struct SearchCollectionPhoto: Codable {
    var results: [CollectionPhoto]
}

// MARK: - CollectionPhoto
struct CollectionPhoto: Codable {
    var id: String
    var urls: Urls?
}

// MARK: - Urls
struct Urls: Codable {
    var raw, full, regular, small, thumb, smallS3: String?
}
