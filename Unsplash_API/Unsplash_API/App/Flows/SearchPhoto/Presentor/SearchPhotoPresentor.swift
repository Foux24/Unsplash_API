//
//  SearchPhotoPresentor.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

// MARK: - SearchPhotoPresentor
final class SearchPhotoPresentor {
    
    /// ViewController
    weak var viewInput: SearchPhotoViewInput?
    
    /// Interactor
    let interactor: SearchPhotoInteractorInput
    
    /// router
    let router: SearchPhotoRouterInput
    
    /// Инициализтор
    ///  - Parameters:
    ///   - interactor: interacotr
    ///   - roter: router
    init(interactor: SearchPhotoInteractorInput, router: SearchPhotoRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SearchPhotoPresentor
extension SearchPhotoPresentor: SearchPhotoViewOutput {
    
    /// Поиск фотографий по имени
    ///  - Parameter query: Искомый текст
    func viewDidSearch(with query: String) {
        interactor.searchPhoto(textSearch: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.viewInput?.searchResultsModel = photos
                self.viewInput?.searchResults = self.getURLsPhotos(arrayPhoto: photos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Запрос на сервер для поиска рендомных фото
    func viewDidRendomPhoto() {
        interactor.loadRendomPhoto { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.viewInput?.searchResultsModel = photos
                self.viewInput?.searchResults = self.getURLsPhotos(arrayPhoto: photos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// переход на экран деталей выбранной фотографий
    ///  - Parameter id: id фотографии
    func viewDidSelectPhoto(id: String) {
        router.viewDidSelectPhoto(id: id)
    }
}

// MARK: - Private
private extension SearchPhotoPresentor {
    
    /// Вытащим урл из обьектов рендомно полученых фото
    /// - Parameter arrayPhoto: Коллекция фотографий
    func getURLsPhotos(arrayPhoto: [CollectionPhoto]) -> [String] {
        let urls: [String] = arrayPhoto.map { $0.urls?.thumb ?? "" }
        return urls
    }
}

