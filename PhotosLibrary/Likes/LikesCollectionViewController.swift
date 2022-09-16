//
//  LikesCollectionViewController.swift
//  PhotosLibrary
//
//  Created by Поляндий on 12.09.2022.
//

import Foundation
import UIKit


class LikesCollectionViewController: UICollectionViewController{
    
    var photos = [UnsplashPhoto]()
    
    private let enterSearchTermItemLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't add a photo yet"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(LikesCollectionViewCell.self, forCellWithReuseIdentifier: LikesCollectionViewCell.reuseId)
        collectionView.contentInset = UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        setupEnterLabel()
        setupNavigationBar()
    }
    
//MARK: - Setup UI Elemets
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermItemLabel)
        enterSearchTermItemLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermItemLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "FAVOURITES"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
//MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermItemLabel.isHidden = photos.count != 0
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionViewCell.reuseId, for: indexPath) as! LikesCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
}

extension LikesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width / 3 - 1, height: width / 3 - 1)
    }
}
