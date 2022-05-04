//
//  SearchPhotoInteractor.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import Alamofire

/// Входящий протокол интерактора
protocol SearchPhotoInteractorInput {
    
    /// Загрузка рендомных фото
    /// - Parameter comlpletion: Блок обрабатывающий запрос
    func loadRendomPhoto(completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void)
    
    /// Поиск фото по тексту
    /// - Parameters:
    ///  - textSearch: Текст имени фото
    ///  - completion: Блок обрабатывающий запрос
    func searchPhoto(textSearch: String, completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void)
}

// MARK: - SearchPhotoInteractor
final class SearchPhotoInteractor {
    
    /// NetworkService
    private let networkService: NetworkServiceOtput
    
    /// Инициализатор
    ///  - Parameter networkService: Сервис для работы с сетью
    init(networkService: NetworkServiceOtput) {
        self.networkService = networkService
    }
}

// MARK: - Extension SearchPhotoInteractor on the SearchPhotoInteractorInput
extension SearchPhotoInteractor: SearchPhotoInteractorInput {
    
    /// Загруза рендомных фото
    func loadRendomPhoto(completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void) {
        networkService.loadRendomPhoto(completion: completion)
    }
    
    /// Загрузка фото по искомому тексту
    func searchPhoto(textSearch: String, completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void) {
        networkService.searchPhoto(textSearch: textSearch, completion: completion)
    }
}
