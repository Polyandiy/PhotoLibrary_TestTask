//
//  FullScreenViewController.swift
//  PhotosLibrary
//
//  Created by Поляндий on 13.09.2022.
//

import Foundation
import UIKit
import SDWebImage

class FullScreenViewController: UIViewController, UIScrollViewDelegate {
    
    var selectedIndex: Int = 0
    var photos = [UnsplashPhoto]()
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentMode = .scaleAspectFit
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = true
        sv.backgroundColor = .black
        return sv
    }()
    
    //MARK: - Buttons
    private var favouriteButton: UIBarButtonItem = {
        let favouriteImage = UIImage(systemName: "heart")
        return UIBarButtonItem(image: favouriteImage, style: .plain, target: self, action: #selector(favouriteButtonTapped))
    }()
    
    private var closeButton: UIBarButtonItem = {
        let closeImage = UIImage(systemName: "chevron.backward.circle")
        return UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTapped))
    }()
    
    private var infoButton: UIBarButtonItem = {
        let infoImage = UIImage(systemName: "info.circle")
        return UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(infoButtonTapped))
    }()
    
    //MARK: - viewDidiLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        setupNavigationBar()
        //setupScrollButtons()
        setupPhotoImageView()
        setupGesture()
        loadImage()
    }
    
    //MARK: - Button settings
    @objc func favouriteButtonTapped(){
        print("like")
//не работает
        let image = photos[selectedIndex]
        let alertController = UIAlertController(title: "", message: "This picture will be added to your favorites.", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            let likeVC = LikesCollectionViewController()
            likeVC.photos.append(image)
            self.favouriteButton.image = UIImage(systemName: "heart.fill")
            likeVC.collectionView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in })
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc func closeButtonTapped() {
//не работает
        dismissCVC()
        print("close")
    }
//не работает
    @objc func infoButtonTapped() {
        print("info")
        let alertController = UIAlertController(title: "Подробная информация", message: "info", preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .default, handler: { _ in })
        alertController.addAction(close)
        alertController.present(alertController, animated: true)
    }
    
    //MARK: - Setup UI Elements
    
    func setupPhotoImageView() {
        scrollView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItems = [infoButton, favouriteButton]
    }
    
    //MARK: - setupGesture
//НЕ РАБОТАЕТ
    func setupGesture() {
        let rigthSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeFrom(recognizer:)))
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeFrom(recognizer:)))
        
        rigthSwipe.direction = .right
        leftSwipe.direction = .left
        
        scrollView.addGestureRecognizer(rigthSwipe)
        scrollView.addGestureRecognizer(leftSwipe)
    }
    
    @objc private func handleSwipeFrom(recognizer: UISwipeGestureRecognizer) {
        let direction: UISwipeGestureRecognizer.Direction = recognizer.direction
        
        switch direction {
        case UISwipeGestureRecognizer.Direction.right:
            self.selectedIndex -= 1
        case UISwipeGestureRecognizer.Direction.left:
            self.selectedIndex += 1
        default:
            break
        }
        self.selectedIndex = (self.selectedIndex < 0) ? (self.photos.count - 1) : self.selectedIndex % self.photos.count
        
        loadImage()
    }
    
    //MARK: - loadImage
//Добавить функцию
    private func loadImage() {
        let photoURL = photos[selectedIndex].urls["regular"]
        guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
        photoImageView.sd_setImage(with: url, completed: nil)
    }
}

extension UIViewController{
    func dismissCVC() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .reveal
        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: true)
    }
}
