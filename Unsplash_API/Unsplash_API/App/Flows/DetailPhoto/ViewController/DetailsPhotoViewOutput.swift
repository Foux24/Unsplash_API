//
//  DetailsPhotoViewOutput.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

/// Исходящий протокол событий для контроллера
protocol DetailsPhotoViewOutput: AnyObject {
    
    /// Зпрос для получения деталей фото
    /// - Parameters:
    ///  - id: id фото
    ///  - completion: блок обрабатывающий запрос
    func viewDidDetailsPhoto(id: String, complition: @escaping () -> Void)
    
    /// Форматирование даты
    /// - Parameters:
    ///  - dateString: Дата в формате String
    ///  - format: формат даты
    func dateFromString(_ dateString: String,  format: String) -> String?
    
    /// Показ алерта при добавлении фото в БД
    func showAlertAddPhotoInDB() -> Void
   
    /// Показ алерта при удалении фото из БД
    func showAlertDeletPhotoInDB() -> Void
}
