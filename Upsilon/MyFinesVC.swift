//
//  MyFinesVC.swift
//  Upsilon
//
//  Created by Pavel Seleznev on 5/7/19.
//  Copyright © 2019 Pavel Seleznev. All rights reserved.
//

import UIKit

class MyFinesVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSMutableAttributedString(string: "проверить штрафы")
        let url = URL(string: "https://www.apple.com/")
        
        // Set the "click here" substring to be the link
        attributedString.setAttributes([.link: url as Any], range: NSMakeRange(0, 16))
        self.textView.attributedText = attributedString
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false
        
        // Set how links should appear: blue and underlined
        self.textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}
