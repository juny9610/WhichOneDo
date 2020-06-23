//
//  WriteViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class WriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var btnDone: UIBarButtonItem!
    @IBOutlet var contentsTitle: UITextField!
    @IBOutlet var contents: UITextView!
    var time: String?
    var nickname: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        placeholerSetting()
        
    
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func placeholerSetting() {
        contents.delegate = self
        contents.text = "내용을 입력하세요"
        contents.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "내용을 입력하세요"
                textView.textColor = UIColor.lightGray
            }
        }
    
    //작성화면을 database로 전달
    @IBAction func writeDoneEvent(_ sender: UIBarButtonItem) {
        let uid = Auth.auth().currentUser?.uid
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let write_time_string = formatter.string(from: Date())
        Database.database().reference().child("singleUsers").child(uid!).observe(DataEventType.value, with: {
            (datasnapshot) in
            let singleUser = SingleUserModel()
            singleUser.setValuesForKeys(datasnapshot.value as! [String : Any])
            self.nickname = singleUser.userNickName
            let value: Dictionary<String, Any> = ["title": self.contentsTitle.text!, "contents": self.contents.text!, "time": write_time_string, "userId": self.nickname!, "likeNum": "0", "commentsNum": "0"]
            Database.database().reference().child("community").childByAutoId().setValue(value)
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}


