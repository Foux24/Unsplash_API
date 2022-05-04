//
//  RealmModel.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import Foundation
import RealmSwift

/// Модель фото
class RealmModelPhoto: Object, Codable {
    
    /// УРЛ фото
    @objc dynamic var url: String = ""
    
    /// ЙД Фото
    @objc dynamic var id: String = ""
    
    /// имя автора
    @objc dynamic var nameAuthor: String = ""
    
    /// IdentifairKey
    override class func primaryKey() -> String? {
        "id"
    }
}
