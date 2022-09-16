//
//  PhotoCell.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    static let reuseID = "PhotoCell"
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 1
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
            photoImageView.sd_setImage(with: url , completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
    }
    
    
    func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
