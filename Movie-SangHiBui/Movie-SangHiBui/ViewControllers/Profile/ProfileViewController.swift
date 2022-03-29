//
//  ProfileViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 27/12/2021.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var viewOfImage: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var idLB: UILabel!
    @IBOutlet weak var logoutButton: UIButton!

    var sessionID: String?
    var accountID: Int?
    var id: Int?
    var name: String?
    var userName: String?
    var avatarPath: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomUI()
        getDetailsAccount()
        imageViewAvatar.sd_setImage(with: URL(string: Constants.baseURLPathImage + (avatarPath ?? "")), placeholderImage: UIImage(named: "albums"))
        idLB.text = "ID: + \((id ?? 0)) "
        nameLB.text = "Name: " + (name ?? "")
        userNameLB.text = "UserName: " + (userName ?? "")
        

    }
    
    private func CustomUI() {
        viewOfImage.layer.cornerRadius = 125
        imageViewAvatar.layer.cornerRadius = 125
        logoutButton.layer.cornerRadius = 20
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        
        UserService.shared.removeData()
        
        let storyboard = UIStoryboard(name: "NewFeed", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        
    }
    
}

extension ProfileViewController {
    private  func getDetailsAccount() {
        APIService.requestDetailAccount() { error, detailAccount in
            guard let detailAccount = detailAccount else { return }
            self.idLB.text = "ID: \(detailAccount.id ?? 0) "
            self.nameLB.text = "Name: " + (detailAccount.name ?? "")
            self.userNameLB.text = "UserName: " + (detailAccount.username ?? "")
            self.imageViewAvatar.sd_setImage(with: URL(string: Constants.baseURLPathImage + (detailAccount.avatar?.tmdb?.avatarPath ?? "" ) ), placeholderImage: UIImage(named: "albums"))
        }
    }
}


