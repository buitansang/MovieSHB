//
//  DetailMovieCollectionViewCell.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 15/11/2021.
//

import UIKit

class DetailMovieCollectionViewCell: UICollectionViewCell {

    // MARK : - Outlets
    @IBOutlet weak var imageViewCast: UIImageView!
    @IBOutlet weak var labelNameCasts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewCast.layer.cornerRadius = 25
        
    }

}
