//
//  LikedPhotoPresentor.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import RealmSwift

// MARK: - LikedPhotoPresentor
final class LikedPhotoPresentor {
    
    /// Свойство для контроллера
    weak var viewInput: LikedPhotoViewInput?
    
    /// Ссылка на роутер экрана
    private let router: LikedPhotoRouterInput
    
    /// Инициализтор
    init(router: LikedPhotoRouterInput) {
        self.router = router
    }
}

//MARK: - LikedPhotoPresentor
extension LikedPhotoPresentor: LikedPhotoViewOutput {
    
    /// Метод выдернем ИД фото из контроллера
    func viewDidSelectPhoto(id: String) {
        router.viewDidSelectPhoto(id: id)
    }
    
    ///  Алерт на удаления фото
    func showAlertDeletAllPhoto() -> Void {
        self.viewInput?.showAlert(title: "Удаленно", message: "Все фотографии удалены")
    }
}
