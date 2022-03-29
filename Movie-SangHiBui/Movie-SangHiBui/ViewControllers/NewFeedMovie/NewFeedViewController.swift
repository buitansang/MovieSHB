//
//  NewFeedViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 27/10/2021.
//

import UIKit
import SDWebImage


class NewFeedViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionViewRecomended: UICollectionView!
    @IBOutlet weak var collectionViewTopRated: UICollectionView!
    @IBOutlet weak var viewBlack: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!

    
    // MARK: - Properties
    
    var page = 0
    var popularMovie: [NewFeedMovie] = []
    var topRatedMovie: [NewFeedMovie] = []
    var favoriteMovie: [NewFeedMovie] = []
    var movieFavoriteIDSet: Set<Int?> = []
    var voteAverage: Float = 0.0
    var sessionID: String?
    var accountID: Int?
   
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getPopularMovie()
        getTopRated()
        getFavoriteMovie()
        setupRecomendedView()
        setupTopRatedView()
        customUI()
        setupsTextField()
        
    }
   
//     MARK: - Setups
    
    private func setupRecomendedView() {
        collectionViewRecomended.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        collectionViewRecomended.delegate = self
        collectionViewRecomended.dataSource = self
        collectionViewRecomended.register(UINib(nibName: "NewFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedCollectionViewCell")
    }
    
    private func setupTopRatedView() {
        collectionViewTopRated.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        collectionViewTopRated.delegate = self
        collectionViewTopRated.dataSource = self
        collectionViewTopRated.register(UINib(nibName: "NewFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedCollectionViewCell")
    }
    // Tuỳ chỉnh UI
    private func customUI() {
        viewBlack.layer.cornerRadius = 20
        viewBlack.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        searchView.layer.cornerRadius = 15
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
    }
    
    private func setupsTextField() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextFieldDidBegin(_:)), for: .editingDidBegin)
    }
    // Nhấn vào textField Search
    @objc func searchTextFieldDidBegin(_ sender: UITextField) {
        view.endEditing(true)
        let sb = UIStoryboard.init(name: "NewFeed", bundle: nil)
        if let searchScreenVC = sb.instantiateViewController(withIdentifier: "SearchMovieViewController") as? SearchMovieViewController {
            searchScreenVC.sessionID = self.sessionID
            searchScreenVC.accountID = self.accountID
            self.navigationController?.pushViewController(searchScreenVC, animated: true)
        }
    }
    // Chuyển màn hình Search Popular Movie
    @IBAction func didTapSeeAllPopular(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "NewFeed", bundle: nil)
        if let searchScreenVC = sb.instantiateViewController(withIdentifier: "SearchMovieViewController") as? SearchMovieViewController {
            searchScreenVC.flag = 1
            searchScreenVC.sessionID = self.sessionID
            searchScreenVC.accountID = self.accountID
            self.navigationController?.pushViewController(searchScreenVC, animated: true)
        }
    }
    // Chuyển màn hình Search Top Rate Movie
    @IBAction func didTapSeeAllTopRate(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "NewFeed", bundle: nil)
        if let searchScreenVC = sb.instantiateViewController(withIdentifier: "SearchMovieViewController") as? SearchMovieViewController {
            searchScreenVC.flag = 2
            searchScreenVC.sessionID = self.sessionID
            searchScreenVC.accountID = self.accountID
            self.navigationController?.pushViewController(searchScreenVC, animated: true)
        }
    }
    
}

extension NewFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewRecomended {
            return popularMovie.count
        }
        return topRatedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedCollectionViewCell", for: indexPath) as! NewFeedCollectionViewCell
        if collectionView == collectionViewRecomended && popularMovie.count > 0 {
            let movie = popularMovie[indexPath.item]
            cell.labelMovieName.text = movie.title
            cell.imgViewMovie.sd_setImage(with: URL(string: movie.getPosterImage()), placeholderImage: UIImage(named: "Movie1.png"))
            if let vote = popularMovie[indexPath.item].voteAverage {
                cell.checkVoteStar(vote: vote)
            }
        }
       
        if collectionView == collectionViewTopRated && topRatedMovie.count > 0 {
            let movie = topRatedMovie[indexPath.item]
            cell.labelMovieName.text = movie.title
            cell.imgViewMovie.sd_setImage(with: URL(string: movie.getPosterImage()), placeholderImage: UIImage(named: "Movie1.png"))
            if let vote = topRatedMovie[indexPath.item].voteAverage {
                cell.checkVoteStar(vote: vote)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 261)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewRecomended && popularMovie.count > 0 {
            let movie = popularMovie[indexPath.item]
            let storyboard = UIStoryboard.init(name: "NewFeed", bundle: nil)
            if let detailScreenVC = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
                detailScreenVC.movieId = movie.id
                detailScreenVC.sessionID = self.sessionID
                detailScreenVC.accountID = self.accountID
                detailScreenVC.movieFavoriteIDSet = self.movieFavoriteIDSet
                self.navigationController?.pushViewController(detailScreenVC, animated: true)
            }
        }
       
        if collectionView == collectionViewTopRated && topRatedMovie.count > 0 {
            let movie = topRatedMovie[indexPath.item]
            let storyboard = UIStoryboard.init(name: "NewFeed", bundle: nil)
            if let detailScreenVC = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
                detailScreenVC.movieId = movie.id
                detailScreenVC.sessionID = self.sessionID
                detailScreenVC.accountID = self.accountID
                detailScreenVC.movieFavoriteIDSet = self.movieFavoriteIDSet
                self.navigationController?.pushViewController(detailScreenVC, animated: true)
            }
        }
    }
}
// Call API
extension NewFeedViewController {
    // Call API lấy data Popular Movie
    private func getPopularMovie() {
        APIService.getMovie(with: .popularMovie) { movies in
            guard let movies = movies else { return }
            
            DispatchQueue.main.async {
                self.popularMovie = movies
                self.collectionViewRecomended.reloadData()
            }
        }
    }
    
    // Call API lấy data Top Rate Movie
    private func getTopRated() {
        APIService.getMovie(with: .topRatedMovie) { movies in
            guard let movies = movies else { return }
            
            DispatchQueue.main.async {
                self.topRatedMovie = movies
                self.collectionViewTopRated.reloadData()
            }
        }
    }
    
    func getFavoriteMovie() {
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
