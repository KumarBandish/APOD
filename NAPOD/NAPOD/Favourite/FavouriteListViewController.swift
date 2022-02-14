//
//  FavouriteListViewController.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import UIKit
import Kingfisher

class FavouriteListViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    //MARK: Property
    var pictureDetails: [PictureDetails]? {
        didSet {
            DispatchQueue.main.async {
                self.favouriteCollectionView.reloadData()
            }
        }
    }
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromStorage()
    }
    
    //MARK: Methods
    private func fetchDataFromStorage() {
        let data = CoreDataManager.sharedInstance.fetch(PictureDetails.self)
        pictureDetails = data
    }
    
    func showAlert() {
        let alert = UIAlertController(title: Constant.ErrorAlertTitle, message: Constant.noFavouriteListMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.OkAlertTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}
//MARK: Collection View Delegate & DataSource
extension FavouriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        guard let data = pictureDetails else {
            return UICollectionViewCell()
        }
        cell.configureUI(pictureDetail: data[indexPath.row])
        return cell
    }
}


extension FavouriteListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12 * 3) / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
}
