//
//  DetailMovieViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 12/11/2021.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var viewBackdropImage: UIView!
    @IBOutlet weak var stackViewName: UIStackView!
    @IBOutlet weak var collectionViewCasts: UICollectionView!
    @IBOutlet weak var imageViewLogo4K: UIImageView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var studio: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var re: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    
    // MARK: - Properties
    
    var movieId: Int?
    var sessionID: String?
    var accountID: Int?
    var detailMovie: DetailMovie?
    var castsMovie: [CastMovie] = []
    var watchMovies: [WatchMovie] = []
    var favoriteMovie: [NewFeedMovie] = []
    var movieFavoriteIDSet: Set<Int?> = []
    var isFavoriteMovie: Bool = false
    
    // MARK: - Life Cycle
    
    convenience init(movieId: Int?, sessionID: String?, accountID: Int?) {
        self.init()
        self.movieId = movieId
        self.sessionID = sessionID
        self.accountID = accountID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupsCastsView()
        getDetailMovie()
        getCastsMovie()
        getWatchMovies()
        customUI()
    }
    

    
    // MARK: - Setups
    
    private func setupsCastsView() {
        collectionViewCasts.contentInset = UIEdgeInsets(top: 0 , left: 30, bottom: 0, right: 0)
        collectionViewCasts.delegate = self
        collectionViewCasts.dataSource = self
        collectionViewCasts.register(UINib(nibName: "DetailMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailMovieCollectionViewCell")
    }
    
    private func getTextStudio() -> String {
        var name = ""
        if let arr = detailMovie?.productionCompanies {
            for nameTmp in arr  {
                name += (nameTmp.name ?? "")  +  ", "
                }
        }
        name = String(name.dropLast())
        return String(name.dropLast())
    }
    
    private func getTextGenges() -> String {
        var name = ""
        if let arr = detailMovie?.genres {
            for nameTmp in arr  {
                name += (nameTmp.name ?? "")  +  ", "
                }
        }
        name = String(name.dropLast())
        return String(name.dropLast())
    }
    
    private func getYearRelease() -> String {
        var year = ""
        if let yearTmp = detailMovie?.releaseDate {
            year = String(yearTmp[yearTmp.startIndex..<yearTmp.index(yearTmp.startIndex, offsetBy: 4)])
        }
        return year
    }
    
    private func checkVoteStar(vote: Double) {
       if vote == 0  {
           self.imgStar1.image = UIImage(systemName: "star")
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
    
    private func setupsUI() {
        self.originalTitle.text = detailMovie?.originalTitle
        self.overview.text = detailMovie?.overview
        self.studio.text = getTextStudio()
        self.genre.text = getTextGenges()
        self.re.text = getYearRelease()
        self.imageViewPoster.sd_setImage(with: URL(string: detailMovie?.getBackdropPath() ?? ""), placeholderImage: UIImage(named: "poster"))
        checkVoteStar(vote: detailMovie?.voteAverage ?? 0)
    }
    
    private func customUI() {
        watchButton.layer.cornerRadius = 8
        imageViewLogo4K.image = UIImage(named: "Mask")
        viewBackdropImage.layer.cornerRadius = 20
        viewBackdropImage.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if movieFavoriteIDSet.contains(movieId) {
            if let image = UIImage(systemName: "heart.fill") {
                loveButton.tintColor = .systemYellow
                loveButton.setImage(image, for: .normal)
                isFavoriteMovie = true
            }
        }
        
    }
    
    // Button Back
    @IBAction func backToNewFeed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapWatch(_ sender: UIButton) {
        let sb = UIStoryboard(name: "NewFeed", bundle: nil)
        if let wacthMovieVC = sb.instantiateViewController(withIdentifier: "WatchMovieViewController") as? WatchMovieViewController {
            wacthMovieVC.watchMovies = watchMovies
            self.navigationController?.pushViewController(wacthMovieVC, animated: true)
        }
    }
    
    @IBAction func didTapFavoriteMovie(_ sender: UIButton) {
        if isFavoriteMovie {
            if let image = UIImage(systemName: "heart") {
                loveButton.tintColor = .white
                loveButton.setImage(image, for: .normal)
            }
            movieFavoriteIDSet.remove(movieId)
        } else {
            if let image = UIImage(systemName: "heart.fill") {
                loveButton.tintColor = .systemYellow
                loveButton.setImage(image, for: .normal)
            }
        }
        maskFavoriteMovie(isFavorite: !isFavoriteMovie)
        
        let alert = UIAlertController(title: "Success", message: "The item was updated successfully", preferredStyle: .alert)
        
        let actionCencal = UIAlertAction (title: "Cencal", style: .cancel) { (action) in
        }
        alert.addAction(actionCencal)
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castsMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let castsMovie = castsMovie[indexPath.row]
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCollectionViewCell", for: indexPath) as! DetailMovieCollectionViewCell
        cell.imageViewCast.sd_setImage(with: URL(string: castsMovie.getprofilePath()), placeholderImage: UIImage(named: "Cast"))
        cell.labelNameCasts.text = castsMovie.originalName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 96)
    }
}

// Call API
extension DetailMovieViewController {
    // Call API get data detail movie
    private func getDetailMovie() {
        APIService.requestGetDetailMovie(with: movieId ?? 0) { detailMovie in
            guard let  dMovie = detailMovie else { return }
            DispatchQueue.main.async {
                self.detailMovie = dMovie
                self.setupsUI()
            }
        }
    }
    
    private func getCastsMovie() {
        APIService.requestCastsMovie(with: movieId ?? 0) { castsMovie in
            guard let cMovie = castsMovie else { return }
            DispatchQueue.main.async {
                self.castsMovie = cMovie
                self.collectionViewCasts.reloadData()
            }
        }
    }
    
    private func getWatchMovies() {
        APIService.requestWatchMovie(with: movieId ?? 0) { watchMovies in
            guard let wMovies = watchMovies else { return }
            self.watchMovies = wMovies
        }
    }
    
    private func maskFavoriteMovie(isFavorite: Bool) {
        APIService.maskFavoriteMovie(movieID: movieId ?? 0, isFavorite: isFavorite) { maskFavoriteMovie in
            if let maskFavoriteMovie = maskFavoriteMovie {
                print(maskFavoriteMovie.statusMessage)
                self.isFavoriteMovie = !self.isFavoriteMovie
            }
        }

    }
    private func getFavoriteMovie() {
       APIService.requestFavoriteMovie() { movies in
           guard let movies = movies else { return }
    
           DispatchQueue.main.async {
               self.favoriteMovie = movies
               for index in 0..<self.favoriteMovie.count {
                   self.movieFavoriteIDSet.insert(self.favoriteMovie[index].id)
               }
           }
       }
   }  
}

