//
//  MainTabBarController.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let likesVC = LikesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let imageOne = UIImage(systemName: "photo")
        let imageTwo = UIImage(systemName: "heart.fill")
        
        viewControllers = [generateNavigationVC(rootViewController: photosVC, title: "Photos", image: imageOne!),
                           generateNavigationVC(rootViewController: likesVC, title: "Favourites", image: imageTwo!)]
    }
    
    private func generateNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
    
}
