//
//  SignupViewController.swift
//  WhichOneDo
//
//  Created by 강희선 on 2020/05/23.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class SignupViewController: UIViewController {
    @IBOutlet var tfUserName: UITextField!
    @IBOutlet var tfUserEmail: UITextField!
    @IBOutlet var tfUserPassword: UITextField!
    @IBOutlet var btnSignUpDone: UIButton!
    @IBOutlet var btnSignUpCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignUpDone.addTarget(self, action: #selector(SignUpEvent), for: .touchUpInside)
        btnSignUpCancel.addTarget(self, action: #selector(SignUpCancelEvent), for: .touchUpInside)
    }
    
    @objc func SignUpEvent(){
        Auth.auth().createUser(withEmail: tfUserEmail.text!, password: tfUserPassword.text!, completion: {(user, err) in
            if user != nil{
                let uid = user?.user.uid
                let value = ["userId" : uid, "userNickName" : self.tfUserName.text!]
                Database.database().reference().child("users").child(uid!).setValue(value, withCompletionBlock: {(err, ref) in
                    if (err == nil){
                        self.SignUpCancelEvent()
                    }
                    else if (err != nil){
                        let alert = UIAlertController(title: "경고", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
                Database.database().reference().child("singleUsers").child(uid!).setValue(value)
            }
        })
    }
    @objc func SignUpCancelEvent(){
        self.dismiss(animated: true, completion: nil)
    }

}
