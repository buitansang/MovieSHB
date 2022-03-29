//
//  LoginViewController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 27/11/2021.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import LocalAuthentication

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFBButton: UIButton!
    @IBOutlet weak var loginGGButton: UIButton!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var faceIDImageView: UIImageView!
    @IBOutlet weak var faceIDView: UIView!

    // MARK: - Properties
    var requesToken: String?
    var requestSessionToken: String?
    var sessionID: String?
    var accountID: Int?
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        accountTextField.text = "sangbui12345"
//        passwordTextField.text = "12345sg2409"
        customUI()
        setupTextField()
        tapOnView()
        startAuthentication()
    }
    
    private func customUI() {
        
        loginButton.layer.cornerRadius = 7
        loginFBButton.layer.cornerRadius = 7
        loginFBButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 4, right: 248)
        loginGGButton.layer.cornerRadius = 7
        loginGGButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 4, right: 248)
        loginGGButton.layer.borderColor = UIColor.black.cgColor
        loginGGButton.layer.borderWidth = 0.5
    }
    
    private func tapOnView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen))
        self.view.addGestureRecognizer(gesture)
    }
    private func startAuthentication() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapFaceID))
        faceIDView.addGestureRecognizer(gesture)
    }
    @objc func didTapFaceID() {
        
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reasons = " Please authorize with Face ID !"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasons) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    self?.getToken()
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

    @IBAction func tapLogin(_ sender: UIButton) {
        guard let username = accountTextField.text, let password = passwordTextField.text else {
            // show thong bao nhap username pass hoac something
            return
        }
        
        if username == "" {
            let alert = UIAlertController(title: "Wrong Username", message: "Username must not be empty", preferredStyle: .alert)
            
            let actionCencal = UIAlertAction (title: "Cencal", style: .cancel) { (action) in
                self.accountTextField.text = ""
                self.passwordTextField.text = ""
                self.accountTextField.becomeFirstResponder()
            }
            alert.addAction(actionCencal)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if password == "" {
            // thong bao cac kieu
            let alert = UIAlertController(title: "Wrong Password", message: "Password must not be empty", preferredStyle: .alert)
            
            let actionCencal = UIAlertAction (title: "Cencal", style: .cancel) { (action) in
                self.passwordTextField.text = ""
                self.passwordTextField.becomeFirstResponder()
            }
            alert.addAction(actionCencal)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        getToken()
    }
    
    @IBAction func tapOnLoginGGButton(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logOut()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        GIDSignIn.sharedInstance.signOut()
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                return
              }
            if let user = user {
                self.getToken()
            }
            
        }
    }
    
    @IBAction func tapOnLoginFBButton(_ sender: UIButton) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            loginManager.logOut()
        } else {
             
        loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
            self?.getToken()
            }
        }
    }
    
    @objc func didTapOnScreen() {
        view.endEditing(true)
    }

}

extension LoginViewController: UITextFieldDelegate {

    private func setupTextField() {
        
        accountTextField.addTarget(self, action: #selector(accountTextFieldDidBegin(_:)), for: .editingDidBegin)
        
        accountTextField.addTarget(self, action: #selector(accountTextFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidBegin(_:)), for: .editingDidBegin)
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc func accountTextFieldDidBegin(_ sender: UITextField) {
        accountTextField.textColor = UIColor(named: "blue1")
        accountTextField.tintColor = UIColor(named: "blue1")
        accountImageView.tintColor = UIColor(named: "blue1")
    }
    
    @objc func passwordTextFieldDidBegin(_ sender: UITextField) {
        passwordTextField.textColor = UIColor(named: "blue1")
        passwordTextField.tintColor = UIColor(named: "blue1")
        passwordImageView.tintColor = UIColor(named: "blue1")
    }
    
    @objc func accountTextFieldDidEndEditing(_ sender: UITextField) {
        accountTextField.textColor = .none
        accountTextField.tintColor = .none
        accountImageView.tintColor = .black
    }
    
    @objc func passwordTextFieldDidEndEditing(_ sender: UITextField) {
        passwordTextField.textColor = .none
        passwordTextField.tintColor = .none
        passwordImageView.tintColor = .black
    }
    
}

extension LoginViewController {
    
    private func getToken() {
        APIService.requestToken { token in
            guard let token = token else { return }
            self.requesToken = token.requestToken
            print("TOKEN new: " + (self.requesToken ?? ""))
            self.requestSessionWithLogin()
        }
        
    }
    
    private func requestSessionWithLogin() {
        APIService.requestSessionWithLogin(username: "sangbui12345" ?? "" , password: "12345sg2409" ?? "", token: requesToken ?? "") { token in
            guard let token = token else { return }
            self.requestSessionToken = token.requestToken
            print("TOKEN with Login: " + (self.requestSessionToken ?? ""))
            self.requestSessionID()
        }
    }
    
    private func requestSessionID() {
        APIService.requestSession(token: requesToken ?? "") { session in

            DispatchQueue.main.async {
                self.requestDetailAccount()
            }
        }
    }
   
    private func requestDetailAccount() {
        APIService.requestDetailAccount() { error, detailAccount in
            print(error)
            // chuyen Login => Tabbar
            DispatchQueue.main.async {
                let sb = UIStoryboard.init(name: "NewFeed", bundle: nil)
                let baseTabBarController = sb.instantiateViewController(identifier: "BaseTabBarController") as! BaseTabBarController
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(baseTabBarController)
            }
        }
    }
}
    
    
