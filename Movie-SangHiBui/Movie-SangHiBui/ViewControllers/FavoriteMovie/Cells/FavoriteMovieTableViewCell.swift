//
//  FavoriteMovieTableViewCell.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 29/12/2021.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    
    //MARK : - Outlets
    
    @IBOutlet weak var imageViewPosterPath: UIImageView!
    @IBOutlet weak var labelOriginalTitle: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelOverView: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK : - Setups
    
    func customUI() {
        imageViewPosterPath.layer.cornerRadius = 20
        viewImage.layer.cornerRadius = 20
        viewImage.layer.shadowRadius = 8
        viewImage.layer.shadowOpacity = 0.3
        viewImage.layer.shadowOffset =  CGSize(width: 1 , height: 3)
        viewImage.layer.masksToBounds = false
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
