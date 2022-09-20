//
//  LikesCollectionViewController.swift
//  PhotosLibrary
//
//  Created by Поляндий on 12.09.2022.
//

import Foundation
import UIKit

class LikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos = [UnsplashPhoto]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(LikesTableViewCell.self, forCellReuseIdentifier: LikesTableViewCell.reuseId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "FAVOURITES"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
 
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikesTableViewCell.reuseId, for: indexPath) as? LikesTableViewCell else {
            fatalError()
        }
        let unsplashPhoto = photos[indexPath.row]
        cell.unsplashPhoto = unsplashPhoto
        cell.likeTitleLable.text = photos[indexPath.row].user.username
        
        return cell
    }
    @objc 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LikesTableViewCell
        guard let image = cell.likeImageView.image else { return }
        
        let vc = FullScreenViewController()
        vc.selectedIndex = indexPath.item
        vc.photos = photos
        vc.photoImageView.image = image
        pushVC(viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            self.photos.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

extension UIViewController {
    func pushVC(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
