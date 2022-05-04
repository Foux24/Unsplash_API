//
//  LikedPhotoBuilder.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

// MARK: - LikedPhotoBuilder
final class LikedPhotoBuilder {
    
    /// Билд контроллера для поиска фото
    static func build() -> UIViewController {
        let viewController = LikedPhotoViewController()
        return viewController
    }
}
