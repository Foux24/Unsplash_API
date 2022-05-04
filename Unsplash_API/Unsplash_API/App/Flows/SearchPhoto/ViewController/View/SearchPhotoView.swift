//
//  SearchPhotoView.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import SnapKit

// MARK: - SearchPhotoView
final class SearchPhotoView: UIView {
    
    /// UIsearchBar
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск фото"
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    /// UICollectionView
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collection
    }()
    
    /// инициализтор
    ///  - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstreints()
        self.tapScreen()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Private
private extension SearchPhotoView {
    
    /// Настройка View
    func setupView() {
        self.backgroundColor = .white
    }
    
    /// Добавим UI на View
    func setupUI() {
        self.addSubview(searchBar)
        self.addSubview(collectionView)
    }
    
    /// Настроим констрейнты
    func setupConstreints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    /// Настроим композицию элементов в коллекции
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 5
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    /// Обработка тапа по экрану
    func tapScreen() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        self.addGestureRecognizer(tapScreen)
    }
    
    /// Скрытие клавиатуры
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
