//
//  LikesCollectionViewCell.swift
//  PhotosLibrary
//
//  Created by Поляндий on 12.09.2022.
//

import Foundation
import SDWebImage

class LikesCollectionViewCell: UICollectionViewCell{
    
    static let reuseId = "LikesCollectionViewCell"
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet{
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
            myImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    func setupImage(){
        addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
