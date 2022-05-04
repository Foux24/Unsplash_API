//
//  DetailsPhotoView.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import SnapKit

// MARK: - View для DetailsPhotoViewController
final class DetailsPhotoView: UIView {
    
    /// ScrollView
    private(set) lazy var scrollView = UIScrollView()
    
    /// UIImageView
    private(set) lazy var imageView: UIImageView = {
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
        label.backgroundColor = .white
        return label
    }()
    
    /// UILabel дата создания фото
    private(set) lazy var dateCreatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    /// UILabel место создания фото
    private(set) lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    /// UILabel с количеством загрузок
    private(set) lazy var downloadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    /// Кнопка добавить в избранное
    private(set) lazy var faworiteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 3.0
        button.layer.shadowRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupScrolViewInUIView()
        self.setupUIElementsInScrolView()
        self.setupConstreintsUIElementsInScrolView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// В случаи если фото есть в БД то меняем у кнопки данные
    func elseTrueFavorites() {
        faworiteButton.setTitle("В избранном", for: .normal)
        faworiteButton.backgroundColor = .systemGray5
    }
    
    /// В случаи если фото нет в БД то меняем у кнопки данные
    func elseFalseFavorites() {
        faworiteButton.setTitle("Добавить в избранное", for: .normal)
    }
}

// MARK: - Private
private extension DetailsPhotoView {
    
    /// Add UI
    func setupUIElementsInScrolView() {
        self.backgroundColor = .white
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameAuthorLabel)
        scrollView.addSubview(dateCreatLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(downloadLabel)
        scrollView.addSubview(faworiteButton)
    }
    
    /// Метод установки скрола на вью
    func setupScrolViewInUIView() {
        self.addSubview(scrollView)
    }

    /// раставим констрейнты на скролле
    func setupConstreintsUIElementsInScrolView() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scrollView)
            make.height.equalTo(self.snp.width)
            make.width.equalTo(self.snp.width)
        }
        
        nameAuthorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(imageView.snp.bottom).inset(-5)
        }
        
        dateCreatLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(nameAuthorLabel.snp.bottom).inset(-5)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(dateCreatLabel.snp.bottom).inset(-5)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(locationLabel.snp.bottom).inset(-5)
        }
        
        faworiteButton.snp.makeConstraints { make in
            make.top.equalTo(downloadLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(250)
        }
    }
}
