//
//  NewFeedCollectionViewCell.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 07/11/2021.
//

import UIKit

class NewFeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgViewMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgViewMovie.layer.cornerRadius = 20
       
    }
    
     func checkVoteStar(vote: Double) {
        if vote == 0  {
            imgStar1.image = UIImage(systemName: "star")
            imgStar2.image = UIImage(systemName: "star")
            imgStar3.image = UIImage(systemName: "star")
            imgStar4.image = UIImage(systemName: "star")
            imgStar5.image = UIImage(systemName: "star")
        }
        if vote > 0 && vote < 2 {
            imgStar1.image = UIImage(systemName: "star.lefthalf.fill")
            imgStar2.image = UIImage(systemName: "star")
            imgStar3.image = UIImage(systemName: "star")
            imgStar4.image = UIImage(systemName: "star")
            imgStar5.image = UIImage(systemName: "star")
        }
        if vote == 2 {
            imgStar1.image = UIImage(systemName: "star.fill")
            imgStar2.image = UIImage(systemName: "star")
            imgStar3.image = UIImage(systemName: "star")
            imgStar4.image = UIImage(systemName: "star")
            imgStar5.image = UIImage(systemName: "star")
        }
        if vote > 2 && vote < 4 {
            imgStar1.image = UIImage(systemName: "star.fill")
            imgStar2.image = UIImage(systemName: "star.lefthalf.fill")
            imgStar3.image = UIImage(systemName: "star")
            imgStar4.image = UIImage(systemName: "star")
            imgStar5.image = UIImage(systemName: "star")
        }
        if vote == 4 {
            imgStar1.image = UIImage(systemName: "star.fill")
            imgStar2.image = UIImage(systemName: "star.fill")
            imgStar3.image = UIImage(systemName: "star")
            imgStar4.image = UIImage(systemName: "star")
            imgStar5.image = UIImage(systemName: "star")
        }
         if vote > 4 && vote < 6 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.lefthalf.fill")
             imgStar4.image = UIImage(systemName: "star")
             imgStar5.image = UIImage(systemName: "star")
         }
         if vote == 6 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.fill")
             imgStar4.image = UIImage(systemName: "star")
             imgStar5.image = UIImage(systemName: "star")
         }
         if vote > 6 && vote < 8 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.fill")
             imgStar4.image = UIImage(systemName: "star.lefthalf.fill")
             imgStar5.image = UIImage(systemName: "star")
         }
         if vote == 8 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.fill")
             imgStar4.image = UIImage(systemName: "star.fill")
             imgStar5.image = UIImage(systemName: "star")
         }
         if vote > 8 && vote < 10 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.fill")
             imgStar4.image = UIImage(systemName: "star.fill")
             imgStar5.image = UIImage(systemName: "star.lefthalf.fill")
         }
         if vote == 10 {
             imgStar1.image = UIImage(systemName: "star.fill")
             imgStar2.image = UIImage(systemName: "star.fill")
             imgStar3.image = UIImage(systemName: "star.fill")
             imgStar4.image = UIImage(systemName: "star.fill")
             imgStar5.image = UIImage(systemName: "star.fill")
         }
    }
}
