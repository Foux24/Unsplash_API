//
//  DetailsPhotoViewController.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import RealmSwift

/// Входящий протокол контроллера
protocol DetailsPhotoViewInput: AnyObject {
    
    /// Модель детали фото
    var detailsPhoto: DetailPhoto { get set }
        
    /// Модель фото реалм
    var realmModel: RealmModelPhoto { get set }
    
    /// Показать алерт
    ///  - Parameters:
    ///   - title: Заголовок,
    ///   - message: Сообщение
    func showAlert(title: String, message: String) -> Void
}

// MARK: - DetailsPhotoViewController
final class DetailsPhotoViewController: UIViewController {
    
    /// ID Photo
    var id: String
    
    /// Модель деталей фотографии
    var detailsPhoto = DetailPhoto()
    
    /// Realm
    lazy var realm = RealmManager.shared
    
    /// Флаг наличия фотки в БД Реалм-а
    var flagFavorit = Bool()
    
    /// Получим фотки из БД
    var likedPhoto: Results<RealmModelPhoto>? {
        realm?.getObject(type: RealmModelPhoto.self)
    }
    
    /// Модель для добавления фото в избранное
    var realmModel = RealmModelPhoto()
    
    /// Исходящий протокол событий
    private let output: DetailsPhotoViewOutput
    
    /// Инициализтор
    /// - Parameter output: протокол для исходящих событий
    init(output: DetailsPhotoViewOutput, id: String) {
        self.output = output
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Вью для отображения
    private var castomView: DetailsPhotoView {
        return self.view as! DetailsPhotoView
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        output.viewDidDetailsPhoto(id: id) {
            self.setupValueUI()
        }
        self.view = DetailsPhotoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupFlagFavorit()
    }
}

// MARK: - Extension DetailsPhotoViewController on the DetailsPhotoViewInput
extension DetailsPhotoViewController: DetailsPhotoViewInput {
    
    /// Показ алерта
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private
private extension DetailsPhotoViewController {
    
    /// Заполним полученными данными наш UI
    func setupValueUI() {
        castomView.imageView.loadImage(detailsPhoto.urls?.regular ?? "")
        castomView.nameAuthorLabel.text = "@\(detailsPhoto.user?.name ?? "")"
        castomView.dateCreatLabel.text = "Дата публикации - \(output.dateFromString(detailsPhoto.created_at ?? "", format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ") ?? "")"
        castomView.locationLabel.text = "Локация - \(detailsPhoto.location?.title ?? "Неизвестно")"
        castomView.downloadLabel.text = "Фотография была загружена - \(detailsPhoto.downloads ?? 0) раз"
        castomView.faworiteButton.addTarget(self, action: #selector(logicWorkFavoritButton), for: .touchUpInside)
    }
    
    /// Определим какие данные отобразить кнопке по дефолту
    func setupFlagFavorit() {
        let arrayID: [String] = likedPhoto!.map { $0.id }
        if arrayID.contains(id) {
            flagFavorit = true
            castomView.elseTrueFavorites()
        } else {
            flagFavorit = false
            castomView.elseFalseFavorites()
        }
    }
    
    /// Действие по нажатию на кнопку и ее логика
    @objc func logicWorkFavoritButton() {
        if flagFavorit {
            deletPhotoFavorit()
            flagFavorit = false
        } else {
            addPhotoFavorites()
            flagFavorit = true
        }
    }
    
    /// Добавление обьекта в реалм
    func addPhotoFavorites() {
        try? realm?.add(object: realmModel)
        castomView.elseTrueFavorites()
        output.showAlertAddPhotoInDB()
    }
    
    /// Удаление обьекта из реалм-а
    func deletPhotoFavorit() {
        for objectRealm in likedPhoto! {
            if objectRealm.id == id {
                try? realm?.delete(object: objectRealm)
            }
        }
        castomView.elseFalseFavorites()
        output.showAlertDeletPhotoInDB()
    }
}
