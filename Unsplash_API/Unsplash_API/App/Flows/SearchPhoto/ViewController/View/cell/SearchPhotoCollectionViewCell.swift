//
//  SearchPhotoCollectionViewCell.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import SnapKit

// MARK: - SearchPhotoCollectionViewCell
final class SearchPhotoCollectionViewCell: UICollectionViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: SearchPhotoCollectionViewCell.self)

    /// UIImage
    private(set) lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    /// Конфигурирует ячейку
    ///  - Parameter image: Картинка коллекции
    func configureImage(with image: UIImage?) {
        guard let imageDefault = UIImage(systemName: "photo") else { return }
        photoView.image = image ?? imageDefault
        addUIContentView()
        setupConstraints()
    }
}

// MARK: - Private
private extension SearchPhotoCollectionViewCell {
    
    /// Добавление UI в ячейку
    func addUIContentView() {
        contentView.addSubview(photoView)
    }
    
    /// Установка констрейнтов
    func setupConstraints() {
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
