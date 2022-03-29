//
//  SearchMovieViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 23/11/2021.
//

import UIKit
import SDWebImage

class SearchMovieViewController: UIViewController {

    // MARK : - Outlets
    
    @IBOutlet weak var tableViewMovie: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK : - Properties
    
    var sessionID: String?
    var accountID: Int?
    var popularMovie: [NewFeedMovie] = []
    var topRateMovie: [NewFeedMovie] = []
    var moviesAll: [NewFeedMovie] = []
    var filterMovie: [NewFeedMovie] = []
    var flag: Int = 0 // Dùng để setup data 1: popular, 2: toprate
    
    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    // MARK : - Life Cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupsSearchTextField()
        getPopularMovie()
        getTopRatedMovie()
        customUI()
        setupsTableViewMovie()

    }
    // MARK : - Setups
    
    private func setupsTableViewMovie() {
        tableViewMovie.dataSource = self
        tableViewMovie.delegate = self
        tableViewMovie.register(UINib(nibName: "SearchMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMovieTableViewCell")
        
    }
    
    private func setupsMovieForTableView() {
        if flag == 1 {
            moviesAll = popularMovie
        }
        if flag == 2 {
            moviesAll = topRateMovie
        }
        filterMovie = moviesAll
    }
    
    private func setupsTextField() {
        searchTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
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
            self.tableViewMovie.reloadData()
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
        tableViewMovie.reloadData()
    }
}

// Custom TableView
extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = filterMovie[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as! SearchMovieTableViewCell
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
            detailScreenVC.sessionID = self.sessionID
            detailScreenVC.accountID = self.accountID
            self.navigationController?.pushViewController(detailScreenVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
}
// Call API
extension SearchMovieViewController {
    
    // Call API lấy data Popular Movie
    private func getPopularMovie() {
        APIService.getMovie(with: .popularMovie) { movies in
            guard let movies = movies else { return }
            DispatchQueue.main.async {
                self.popularMovie =  movies
                self.moviesAll += self.popularMovie
                self.moviesAll.shuffle()
                self.setupsMovieForTableView()
                self.tableViewMovie.reloadData()
            }
        }
    }
    
    // Call API lấy data Top Rate Movie
    private func getTopRatedMovie() {
        APIService.getMovie(with: .topRatedMovie) { movies in
            guard let movies = movies else { return }
            
            DispatchQueue.main.async {
                self.topRateMovie = movies
                self.moviesAll += self.topRateMovie
                self.moviesAll.shuffle()
                self.setupsMovieForTableView()
                self.tableViewMovie.reloadData()
            }
        }
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    func setupsSearchTextField() {
        searchTextField.delegate = self
        setupsTextField()
    }
}
