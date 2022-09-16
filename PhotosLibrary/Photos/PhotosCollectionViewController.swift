//
//  PhotosCollectionViewController.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFether()
    private var timer: Timer?
    var photos = [UnsplashPhoto]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        setupEnterLabel()
    }
  
    //MARK: - SearchBar
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: - Setup elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    func setupNavigationBar() {
         let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    //MARK: - UICollectionViewDataSourse, UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        guard let image = cell.photoImageView.image else { return }
        
        let vc = FullScreenViewController()
        vc.selectedIndex = indexPath.item
        vc.photos = photos
        vc.photoImageView.image = image
        pushCVC(viewController: vc)
    }
}

//MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchItem: searchText) { [weak self] (searchResults) in
                guard let fetchPhotos = searchResults else {return}
                self?.photos = fetchPhotos.results
                self?.collectionView.reloadData() 
            }
        })
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availbleWidth = view.frame.width - paddingSpace
        let widthPeritem = availbleWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPeritem / CGFloat(photo.width)
        return CGSize(width: widthPeritem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension UICollectionViewController {
    func pushCVC(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
