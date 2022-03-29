//
//  FavoriteMovieViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 27/12/2021.
//

import UIKit
import SDWebImage

class FavoriteMovieViewController: UIViewController {


    // MARK : - Outlets
    
    @IBOutlet weak var tableViewMoview: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK : - Properties
    
    var sessionID: String?
    var accountID: Int?
    var movieFavoriteIDSet: Set<Int?> = []
    var favoriteMovie: [NewFeedMovie] = []
    var moviesAll: [NewFeedMovie] = []
    var filterMovie: [NewFeedMovie] = []
    var flag: Int = 0 // Dùng để setup data 1: popular, 2: toprate
    
    // MARK : - Life Cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupsSearchTextField()
        setupsTableViewMoview()
        customUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.getFavoriteMovie()
        }
    }
    
    // MARK : - Setups
    
    private func setupsTableViewMoview() {
        tableViewMoview.dataSource = self
        tableViewMoview.delegate = self
        tableViewMoview.register(UINib(nibName: "FavoriteMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteMovieTableViewCell")
        
    }
    
    private func setupsMovieForTableView() {
        moviesAll = favoriteMovie
        filterMovie = moviesAll
    }
    
    private func setupsTextField() {
        searchTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    private func setupsMovieIDArr() {
        for index in 0..<favoriteMovie.count {
            movieFavoriteIDSet.insert(favoriteMovie[index].id)
        }
    }
    
    // Tuỳ chỉnh UI
    private func customUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
    }
    
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        guard let searchText = searchTextField.text else { return }
            self.filterMovie = self.moviesAll.filter({ ($0.originalTitle!.lowercased().contains(searchText.lowercased())) })
        if searchText == "" {
            filterMovie = moviesAll
        }
            self.tableViewMoview.reloadData()
    }
    
    // Button Back
    @IBAction func backToNewFeed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Button Cencal
    @IBAction func didTapCencal(sender: UIButton) {
        searchTextField.text = nil
        searchTextField.endEditing(true)
        filterMovie = moviesAll
        tableViewMoview.reloadData()
    }
}

// Custom TableView
extension FavoriteMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = filterMovie[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieTableViewCell", for: indexPath) as! FavoriteMovieTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 143, bottom: 0, right: 0)
        cell.imageViewPosterPath.sd_setImage(with: URL(string: movie.getPosterImage()), placeholderImage: UIImage(named: "Movie1"))
        cell.labelOriginalTitle.text = movie.originalTitle
        cell.labelRelease.text = movie.releaseDate
        cell.labelVoteAverage.text = String(movie.voteAverage ?? 0)
        cell.checkVoteStar(vote: movie.voteAverage ?? 0)
        cell.labelOverView.text = movie.overview

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = filterMovie[indexPath.row]
        let sb = UIStoryboard(name: "NewFeed", bundle: nil)
        if let detailScreenVC = sb.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
            detailScreenVC.movieId = movie.id
            detailScreenVC.movieFavoriteIDSet = self.movieFavoriteIDSet
            self.navigationController?.pushViewController(detailScreenVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
}

extension FavoriteMovieViewController {
     private func getFavoriteMovie() {
        APIService.requestFavoriteMovie() { movies in
            guard let movies = movies else { return }
            
            DispatchQueue.main.async {
                self.favoriteMovie = movies
                for index in 0..<self.favoriteMovie.count {
                    self.movieFavoriteIDSet.insert(self.favoriteMovie[index].id)
                }
                self.moviesAll += self.favoriteMovie
                self.moviesAll.shuffle()
                self.setupsMovieForTableView()
                self.tableViewMoview.reloadData()
            }
        }
    }
}

extension FavoriteMovieViewController: UITextFieldDelegate {
    func setupsSearchTextField() {
        searchTextField.delegate = self
        setupsTextField()
    }
}
