//
//  SearchPhotoViewOutput.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

/// Выходящий проктол событий для контроллера
protocol SearchPhotoViewOutput {
    
    /// Поиск фотографий по имени
    ///  - Parameter query: Искомый текст
    func viewDidSearch(with query: String)
    
    /// переход на экран деталей выбранной фотографий
    ///  - Parameter id: id фотографии
    func viewDidSelectPhoto(id: String)
    
    /// Загрузка рендомных фотографий
    func viewDidRendomPhoto()
}
