//
//  ViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private var branchList = [String]()
    private var subscribeLikeArray: [SubscribeModels]?
    private var subscribedislikeArray: [SubscribeModels]?
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let margin: CGFloat = 20
        let itemCount: CGFloat = 2
        let frameWidth = view.frame.width
        let contentWidth: CGFloat = frameWidth - (margin * 2) - (padding * (itemCount - 1))
        let itemWidth: CGFloat = (contentWidth / itemCount).rounded(.down)
        
        flowLayout.minimumInteritemSpacing = padding
        flowLayout.minimumLineSpacing = padding
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = AssetsColor.babplusBackground.getColor()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "밥플러스 마이너스"
        loadData()
        searchBarSet()
        setupCollectionView()
        collectionView.isPrefetchingEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeLikeArray = UserDefaultHelper(key: .favoriteStr).getSubscribe()
        subscribedislikeArray = UserDefaultHelper(key: .dislike).getSubscribe()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        collectionViewInitialization()
        navigationItem.searchController?.isActive = false
    }
    
    private func loadData() {
        Constants.APPDELEGATE.dummy?.contents.forEach { branchList.append($0.name) }
    }
    
    // MARK: - collectionView 초기화
    private func collectionViewInitialization() {
        branchList.removeAll()
        loadData()
        collectionView.reloadData()
    }
    
}

extension MainViewController {
    private func setupUI() {
        searchBarSet()
        setupCollectionView()
    }
    
    private func searchBarSet() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "가게명, 메뉴"
        self.navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        collectionView.register(MainBranchCollectionViewCell.self, forCellWithReuseIdentifier: MainBranchCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return branchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainBranchCollectionViewCell.identifier, for: indexPath) as! MainBranchCollectionViewCell
        cell.configure(branchName: self.branchList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MainBranchCollectionViewCell else { return }
        guard let likes = subscribeLikeArray else { return }
        guard let dislikes = subscribedislikeArray else { return }
        var key = highlightSwitch.nothing
        
        Constants.APPDELEGATE.dummy?.contents.forEach { element in
            if element.name == cell.branchName.text {
                for like in likes {
                    if (element.menus.lunch.first(where: { $0.contains(like.name) }) != nil) {
                        key = .babPlus
                        break
                    }
                }
                for dislike in dislikes {
                    if (element.menus.lunch.first(where: { $0.contains(dislike.name) }) != nil) {
                        if key == .babPlus { key = .babPlusMinus } else { key = .babMinus }
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    cell.updateLabel(key: key)
                }
            }
            
        }
        
        
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard branchList.count > indexPath.item,
            let receiveAddress = Constants.APPDELEGATE.dummy?.contents[indexPath.item].address else { return }
        
        let branchDetailVC = BranchDetailViewController()
        branchDetailVC.receiveBranchName = branchList[indexPath.item]
        branchDetailVC.receiveAddress = receiveAddress
        self.navigationController?.pushViewController(branchDetailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        navigationItem.searchController?.isActive = false
        if searchText.count >= 2 {
            branchList.removeAll()
            guard let contents = Constants.APPDELEGATE.dummy?.contents else { return }
            for element in contents {
                if element.name.contains(searchText) ||
                    (element.menus.lunch.first(where: { $0.contains(searchText) }) != nil) ||
                    (element.menus.dinner.first(where: { $0.contains(searchText) }) != nil) {
                    branchList.append(element.name)
                }
                
            }
            
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionViewInitialization()
    }
    
}
