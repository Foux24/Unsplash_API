//
//  SearchPhotoBuilder.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

// MARK: - SearchPhotoBuilder
class SearchPhotoBuilder {
    
    /// Билд контроллера для поиска фото
    static func build() -> UIViewController {
        let viewController = SearchPhotoViewController()
        return viewController
    }
}
