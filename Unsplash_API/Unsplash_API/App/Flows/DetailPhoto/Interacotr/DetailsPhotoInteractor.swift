//
//  DetailsPhotoInteractor.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

/// Входящий протокол интерактора
protocol DetailsPhotoInteractorInput {
    
    /// Получение деталей к фото
    /// - Parameters:
    ///  - id: id фото
    ///  - completion: блок обрабатыващий запрос
    func getDetailPhoto(id: String, completion: @escaping (Result<DetailPhoto, FriendsError>) -> Void)
}

// MARK: - Интереактор
final class DetailsPhotoInteractor {
    
    /// NetworkService
    private let networkService: NetworkServiceOtput
    
    /// Инициализатор
    ///  - Parameter networkService: Сервис для работы с сетью
    init(networkService: NetworkServiceOtput) {
        self.networkService = networkService
    }
}

// MARK: - extension DetailsPhotoInteractor on the DetailsPhotoInteractorInput
extension DetailsPhotoInteractor: DetailsPhotoInteractorInput {
    
    /// Метод запроса деталей для фотографии
    func getDetailPhoto(id: String, completion: @escaping (Result<DetailPhoto, FriendsError>) -> Void) {
        networkService.getDetailPhoto(id: id, completion: completion)
    }
}
