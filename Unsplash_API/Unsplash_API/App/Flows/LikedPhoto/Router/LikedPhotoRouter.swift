//
//  LikedPhotoRouter.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

/// Входящий протокол роутера
protocol LikedPhotoRouterInput {
    /// Переход на экран с деталями к фото
    ///  - Parameter id: id фото
    func viewDidSelectPhoto(id: String)
}

// MARK: - SearchPhotoRouter
final class LikedPhotoRouter: LikedPhotoRouterInput {
    
    /// Ссылка на вью контроллер
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с деталями к фото
    func viewDidSelectPhoto(id: String) {
        let detailsPhotoViewController = DetaildPhotoBuilder.build(id: id)
        viewController?.navigationController?.pushViewController(detailsPhotoViewController, animated: true)
    }
}
