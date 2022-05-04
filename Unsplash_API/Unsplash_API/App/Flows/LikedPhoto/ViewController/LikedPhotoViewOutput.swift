//
//  LikedPhotoViewOutput.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

/// Исходящий протокол событий контроллера
protocol LikedPhotoViewOutput: AnyObject {
    
    /// Переход на экран с деталями фото
    ///  - Parameter id: id фото
    func viewDidSelectPhoto(id: String) -> Void
    
    /// Вызов алерта при удалении всех фото
    func showAlertDeletAllPhoto() -> Void
}
