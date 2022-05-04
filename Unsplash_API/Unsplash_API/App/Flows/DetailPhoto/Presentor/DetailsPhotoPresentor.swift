//
//  DetailsPhotoPresentor.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit


// MARK: - DetailsPhotoPresentor
final class DetailsPhotoPresentor {
        
    /// Свойство вью контроллера
    weak var viewInput: DetailsPhotoViewInput?
    
    /// Ссылка на интерактор
    private let interactor: DetailsPhotoInteractor
    
    /// Инициализтор
    init(interactor: DetailsPhotoInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Extension DetailsPhotoPresentor on the DetailsPhotoViewOutput
extension DetailsPhotoPresentor: DetailsPhotoViewOutput {

    /// Запрос к серверу на получени данных о фото и наполнение данными модели реалма
    /// - Parameters:
    ///  - id: id фото
    ///  - completion: блок обрабатывающий запрос
    func viewDidDetailsPhoto(id: String, complition: @escaping () -> Void) {
        interactor.getDetailPhoto(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detailPhoto):
                self.viewInput?.detailsPhoto = detailPhoto
                self.configerationObjectRealm(object: detailPhoto)
                complition()
            case .failure(let error):
                self.viewInput?.showAlert(title: "Error", message: "\(error)")
            }
        }
    }
    
    /// Для форматирования времени с сервера
    /// - Parameters:
    ///  - dateString: Дата в формате String
    ///  - format: формат даты
    func dateFromString(_ dateString: String, format: String) -> String? {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat =  format
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = tempLocale
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        guard let getdate = date else {
          return nil
        }

        let dateString = dateFormatter.string(from: getdate)
        return dateString
      }

    /// Алерт на удаления фото
    func showAlertDeletPhotoInDB() -> Void {
        self.viewInput?.showAlert(title: "Удаленно", message: "Фотография удалена")
    }
    
    /// Алерт на добавление фото
    func showAlertAddPhotoInDB() -> Void {
        self.viewInput?.showAlert(title: "Добавлено", message: "Фотография добавлена")
    }
}

// MARK: - Private
private extension DetailsPhotoPresentor {
    
    /// С конфигурируем данными модельку реалма для добавления ее в БД
    func configerationObjectRealm(object: DetailPhoto) -> Void {
        self.viewInput?.realmModel.id = object.id ?? ""
        self.viewInput?.realmModel.url = object.urls?.thumb ?? ""
        self.viewInput?.realmModel.nameAuthor = object.user?.username ?? ""
    }
}
