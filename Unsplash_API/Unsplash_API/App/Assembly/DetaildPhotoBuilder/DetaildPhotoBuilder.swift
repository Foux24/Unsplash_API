//
//  DetaildPhotoBuilder.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

// MARK: - DetaildPhotoBuilder
final class DetaildPhotoBuilder {
    
    /// Build
    static func build(id: String) -> UIViewController {
        let networkService = NetworkService()
        let interactor = DetailsPhotoInteractor(networkService: networkService)
        let presentor = DetailsPhotoPresentor(interactor: interactor)
        let viewController = DetailsPhotoViewController(output: presentor, id: id)
        
        presentor.viewInput = viewController
        return viewController
    }
}
