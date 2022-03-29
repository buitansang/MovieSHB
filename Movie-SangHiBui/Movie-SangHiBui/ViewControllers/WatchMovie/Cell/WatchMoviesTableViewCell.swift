//
//  WatchMoviesTableViewCell.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 25/11/2021.
//

import UIKit
import youtube_ios_player_helper

class WatchMoviesTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var playViewMovie: YTPlayerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  playViewMovie.load(withVideoId: (watchMovies.first?.key) ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
