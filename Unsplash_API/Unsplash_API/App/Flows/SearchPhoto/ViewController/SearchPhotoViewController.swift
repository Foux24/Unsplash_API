//
//  SearchPhotoViewController.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

/// Входящий протокол контроллера
protocol SearchPhotoViewInput: AnyObject {
    var fileManager: HashImageService? { get set }
    var searchResultsModel: [CollectionPhoto] { get set }
    var searchResults: [String] { get set }
}

// MARK: - SearchPhotoViewController
final class SearchPhotoViewController: UIViewController {
    
    /// Исходящий протокол событий
    private let output: SearchPhotoViewOutput
    
    /// Массив УРЛ фото
    var searchResults = [String]() {
        didSet {
            castomView.collectionView.reloadData()
            castomView.searchBar.resignFirstResponder()
        }
    }
    
    /// Массив фотографий
    var searchResultsModel = [CollectionPhoto]()
    
    /// Для кеша изоборажений
    var fileManager: HashImageService?
    
    /// Инициализтор
    /// - Parameter output: протокол для исходящих событий
    init(output: SearchPhotoViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Вью для отображения
    private var castomView: SearchPhotoView {
        return self.view as! SearchPhotoView
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = SearchPhotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.viewDidRendomPhoto()
        self.fileManager = HashImageService(container: castomView.collectionView)
        self.setupView()
    }
}

//MARK: - Extension SearchPhotoViewController on the UITableViewDataSource
extension SearchPhotoViewController: UICollectionViewDataSource {
    
    /// Кол-во итемов в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    /// Данные для итема
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castomView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as SearchPhotoCollectionViewCell
        let image = fileManager?.getImage(atIndexPath: indexPath, byUrl: searchResults[indexPath.row])
        cell.configureImage(with: image)
        return cell
    }
}


//MARK: - Extension SearchPhotoViewController on the UITableViewDelegate
extension SearchPhotoViewController: UICollectionViewDelegate {
    
    /// Действие при выделении итема
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output.viewDidSelectPhoto(id: searchResultsModel[indexPath.row].id)
        castomView.collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - Extension SearchPhotoViewController on the UISearchBarDelegate
extension SearchPhotoViewController: UISearchBarDelegate {
    
    /// Поиск фото по нажатию на кнопку
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        output.viewDidSearch(with: query)
    }
    
    /// Если searchBar окажется пустым сделаем новый запрос рендомных фоток
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == true {
            self.output.viewDidRendomPhoto()
            castomView.collectionView.reloadData()
        }
    }
}

// MARK: - extension SearchPhotoViewController on the SearchPhotoViewInput
extension SearchPhotoViewController: SearchPhotoViewInput {}

// MARK: - Private
extension SearchPhotoViewController {
    
    /// Настройка View
    func setupView() {
        self.castomView.collectionView.registerCell(SearchPhotoCollectionViewCell.self)
        self.castomView.collectionView.delegate = self
        self.castomView.collectionView.dataSource = self
        self.castomView.searchBar.delegate = self
    }
}
