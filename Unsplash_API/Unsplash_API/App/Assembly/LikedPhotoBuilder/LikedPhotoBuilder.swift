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
        let router = LikedPhotoRouter()
        let presenter = LikedPhotoPresentor(router: router)
        let viewController = LikedPhotoViewController(output: presenter)
        router.viewController = viewController
        presenter.viewInput = viewController
        return viewController
    }
}
