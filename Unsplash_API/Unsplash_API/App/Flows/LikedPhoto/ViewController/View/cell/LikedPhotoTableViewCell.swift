//
//  LikedPhotoTableViewCell.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import SnapKit

// MARK: - LikedPhotoTableViewCell
final class LikedPhotoTableViewCell: UITableViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: LikedPhotoTableViewCell.self)

    /// UIImage
    private(set) lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    /// UILabel с автором фото
    private(set) lazy var nameAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    /// Конфигуратор для ячейки
    func configurationCell(url: String, nameAuthor: String) {
        photoView.loadImage(url)
        nameAuthorLabel.text = "@\(nameAuthor)"
        setupUIImage()
        setupConstraints()
    }
}

// MARK: - Private
private extension LikedPhotoTableViewCell {
    
    /// Метод  добавления UIImage в ячейку
    func setupUIImage() {
        contentView.addSubview(photoView)
        contentView.addSubview(nameAuthorLabel)
    }
    
    /// Метод установки констрейнтов
    func setupConstraints() {
        
        photoView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(5)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        nameAuthorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(photoView.snp.centerY)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalTo(photoView.snp.leading).inset(-5)
        }
    }
}
