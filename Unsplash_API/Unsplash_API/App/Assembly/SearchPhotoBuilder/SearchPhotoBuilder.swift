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
        let networkService = NetworkService()
        let interactor = SearchPhotoInteractor(networkService: networkService)
        let router = SearchPhotoRouter()
        let presenter = SearchPhotoPresentor(interactor: interactor, router: router)
        let viewController = SearchPhotoViewController(output: presenter)
        
        router.viewController = viewController
        presenter.viewInput = viewController
        
        return viewController
    }
}
