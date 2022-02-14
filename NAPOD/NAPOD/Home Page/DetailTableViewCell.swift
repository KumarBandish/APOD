//
//  DetailTableViewCell.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import UIKit
import Kingfisher

protocol DetailTableViewCellDelegate: AnyObject {
    func favButtonTap()
}

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var explanationLabel: UILabel!
    
    weak var delegate: DetailTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        detailImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView(data: ApodResult) {
        imageTitleLabel.text = data.title
        explanationLabel.text = data.explanation
        setImageFor(url: data.url)
    }
    
    func setImageFor(url: String?) {
        DispatchQueue.main.async {
            let imageURL = URL(string: url ?? "")
            self.detailImageView.kf.setImage(with: imageURL)
        }
    }
    
    @IBAction func addToFavouriteButtonTapped(_ sender: UIButton) {
        delegate?.favButtonTap()
    }
}
