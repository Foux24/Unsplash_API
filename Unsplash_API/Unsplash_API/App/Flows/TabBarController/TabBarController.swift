//
//  TabBarController.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .white
        setupViewControllers()
    }
    
    /// Cоздаём и конфигурируем Navigation Контроллеры, которые будут отображены в табах
    private func setupViewControllers() {
        guard let imageCollection = UIImage(systemName: "photo.on.rectangle.angled") else { return }
        guard let imageMyPhoto = UIImage(systemName: "photo") else { return }
        let collectionPhoto = createNavController(for: SearchPhotoBuilder.build(), title: "Коллекция фотографий", image: imageCollection)
        let myLikedPhoto = createNavController(for: LikedPhotoBuilder.build(), title: "Like Photo", image: imageMyPhoto)
        viewControllers = [collectionPhoto, myLikedPhoto]
    }
    
    ///  Определим метод для настройки NavigationControler-ов
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        return navController
    }
}
