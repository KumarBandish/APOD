//
//  FavouriteCollectionViewCell.swift
//  NAPOD
//
//  Created by BANKUM-BLRM20 on 13/02/22.
//

import UIKit
import Kingfisher

class FavouriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    func configureUI(pictureDetail: PictureDetails) {
        dateLabel.text = Utility().convertDateFormatterToDate(pictureDetail.date!)
        titleLabel.text = pictureDetail.title
        let imageURL = URL(string: pictureDetail.url ?? "")
        pictureImageView.kf.setImage(with: imageURL)
    }
}
