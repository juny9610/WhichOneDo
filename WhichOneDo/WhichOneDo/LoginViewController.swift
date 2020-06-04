//
//  ViewController.swift
//  WhichOneDo
//
//  Created by 강희선 on 2020/05/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    @IBOutlet var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        try! Auth.auth().signOut()
        // Do any additional setup after loading the view.
        btnSignUp.addTarget(self, action: #selector(SignUpEvent), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(LoginEvent), for: .touchUpInside)
        btnSignUp.backgroundColor = UIColor(hex: "503C27")
        btnLogin.backgroundColor = UIColor(hex: "503C27")
        Auth.auth().addStateDidChangeListener{
            (auth, user) in
            if user != nil{
                let view = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
                view.modalPresentationStyle = .fullScreen
                self.present(view, animated: true, completion: nil)
            }
        }
    }
    
    @objc func SignUpEvent(){
        let view = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as! SignupViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    @objc func LoginEvent(){
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!, completion: { (user, err) in
            if err != nil{
                let alert = UIAlertController(title: "경고", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
}
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
