//
//  WriteViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var btnDone: UIBarButtonItem!
    @IBOutlet var contentsTitle: UITextField!
    @IBOutlet var contents: UITextView!
    @IBOutlet var contentsTime: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        placeholerSetting()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let write_time_string = formatter.string(from: Date())
        contentsTime.text = write_time_string

    }
    
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
    
}


