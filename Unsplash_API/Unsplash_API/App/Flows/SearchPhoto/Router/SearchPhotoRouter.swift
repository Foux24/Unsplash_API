//
//  SearchPhotoRouter.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

/// Входящий протокол роутера
protocol SearchPhotoRouterInput {
    func viewDidSelectPhoto(id: String)
}

// MARK: - SearchPhotoRouter
final class SearchPhotoRouter: SearchPhotoRouterInput {
    
    /// Ссылка на вью контроллер
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с деталями к фото
    func viewDidSelectPhoto(id: String) {
//        let detailsPhotoViewController = DetailsPhotoBuilder.build()
//        detailsPhotoViewController.id = id
//        viewController?.navigationController?.pushViewController(detailsPhotoViewController, animated: true)
    }
}
