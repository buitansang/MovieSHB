//
//  SearchMovieViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 25/11/2021.
//

import UIKit
import youtube_ios_player_helper

class WatchMovieViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thongbaoLabel: UILabel!
    //MARK: - Properties
    var watchMovies: [WatchMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupsTableView()
        setupsThongBaoLabel()
    }
    
    private func setupsTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WatchMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "WatchMoviesTableViewCell")
        tableView.separatorStyle = .none
    }
    
    private func setupsThongBaoLabel() {
        if watchMovies.count == 0 {
            thongbaoLabel.text = "Không có bản trailler"
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WatchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let watchMovie = watchMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchMoviesTableViewCell", for: indexPath) as! WatchMoviesTableViewCell
        cell.name.text = watchMovie.name
        cell.playViewMovie.load(withVideoId: watchMovie.key ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
}

