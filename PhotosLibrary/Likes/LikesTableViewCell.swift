//
//  LikesCollectionViewCell.swift
//  PhotosLibrary
//
//  Created by Поляндий on 12.09.2022.
//

import Foundation
import SDWebImage

class LikesTableViewCell: UITableViewCell {
    
    static let reuseId = "LikesViewCell"
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let likeTitleLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet{
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
            likeImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        contentView.addSubview(likeTitleLable)
        contentView.addSubview(likeImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeTitleLable.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.frame.size.width - 170,
            height: 70
        )
        likeImageView.frame = CGRect(
            x: contentView.frame.size.width - 150,
            y: 5,
            width: 150,
            height: contentView.frame.size.height - 10
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeTitleLable.text = nil
        likeImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
