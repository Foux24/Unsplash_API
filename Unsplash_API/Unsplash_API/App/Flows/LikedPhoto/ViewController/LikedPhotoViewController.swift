//
//  LikedPhotoViewController.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import RealmSwift

/// Входящий протокол контроллера
protocol LikedPhotoViewInput: AnyObject {
    /// Показать алерт
    ///  - Parameters:
    ///   - title: Заголовок,
    ///   - message: Сообщение
    func showAlert(title: String, message: String) -> Void
}

// MARK: - LikedPhotoViewController
final class LikedPhotoViewController: UIViewController {
    
    /// Ссылка на Презентор
    private let output: LikedPhotoViewOutput
    
    /// View для отображения
    private var castomView: LikedPhotoView {
        return self.view as! LikedPhotoView
    }
    
    /// ссылка для работы с обьектами реалма
    private lazy var realm = RealmManager.shared
    
    /// Получим фотки из БД для формирования логики работы кнопки удалить и добавить фото в избранное
    private var likedPhoto: Results<RealmModelPhoto>? {
        realm?.getObject(type: RealmModelPhoto.self)
    }
    
    /// Инициализтор презентора
    init(output: LikedPhotoViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = LikedPhotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDeletAllButton()
        castomView.tableView.reloadData()
    }
}

// MARK: Extension - DataSource and Delegate
extension LikedPhotoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPhoto?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castomView.tableView.dequeueReusableCell(forIndexPath: indexPath) as LikedPhotoTableViewCell
        let objectPhoto: RealmModelPhoto = likedPhoto![indexPath.row]
        cell.configurationCell(url: objectPhoto.url, nameAuthor: objectPhoto.nameAuthor)
        return cell
    }
}

extension LikedPhotoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output.viewDidSelectPhoto(id: likedPhoto![indexPath.row].id)
        self.castomView.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private
private extension LikedPhotoViewController {
    
    /// Настроим View
    func setupView() {
        self.castomView.tableView.registerCell(LikedPhotoTableViewCell.self)
        self.castomView.tableView.delegate = self
        self.castomView.tableView.dataSource = self
    }
    
    /// Настройка кнопки по дефолту
    func setDeletAllButton() {
        castomView.deletAllButton.addTarget(self, action: #selector(deletAllRealm), for: .touchUpInside)
        if likedPhoto?.count == 0 {
            castomView.deletAllButton.isHidden = true
            castomView.listEmptyLabel.isHidden = false
        } else {
            castomView.deletAllButton.isHidden = false
            castomView.listEmptyLabel.isHidden = true
        }
    }
    
    /// Метод для кнопки, удаляем данные из БД меняем UI ребути дату у таблицы и показываем алерт
    @objc func deletAllRealm() {
        try? realm?.deleteAll()
        castomView.deletAllButton.isHidden = true
        castomView.listEmptyLabel.isHidden = false
        castomView.tableView.reloadData()
        output.showAlertDeletAllPhoto()
    }
}

/// Расширим клас на проктол
extension LikedPhotoViewController: LikedPhotoViewInput {
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
