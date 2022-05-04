//
//  LikedPhotoView.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit
import SnapKit

// MARK: - LikedPhotoView
final class LikedPhotoView: UIView {
    
    /// UITableView
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 65
        return tableView
    }()
    
    /// SubView для кнопки и лейбла
    private(set) lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// Кнопка добавить в избранное
    private(set) lazy var deletAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delet All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 3.0
        button.layer.shadowRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    /// Определим UILabel
    private(set) lazy var listEmptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray3
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.text = "Список пуст"
        label.isHidden = true
        return label
    }()
    
    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTableView()
        self.setupConstreints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: - Private
private extension LikedPhotoView {
    
    /// Добавим UI на слои
    func setupTableView() {
        self.addSubview(tableView)
        self.addSubview(subView)
        subView.addSubview(deletAllButton)
        subView.addSubview(listEmptyLabel)
    }
    
    /// Установка констрейнтов
    func setupConstreints() {
        subView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.bottom).inset(-8)
            make.bottom.trailing.leading.equalToSuperview()
        }
        
        deletAllButton.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).inset(5)
            make.centerX.equalTo(subView.snp.centerX)
            make.bottom.equalTo(subView.snp.bottom).inset(10)
            make.height.equalTo(20)
            make.width.equalTo(120)
        }
        
        listEmptyLabel.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).inset(5)
            make.centerX.equalTo(subView.snp.centerX)
            make.bottom.equalTo(subView.snp.bottom).inset(10)
        }
    }
}
