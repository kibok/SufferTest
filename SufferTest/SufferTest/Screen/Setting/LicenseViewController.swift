//
//  LicenseViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/29.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = self.readLisences()
    }
    
    func readLisences() -> String? {
        guard let path = Bundle.main.path(forResource: "Lisences", ofType: "txt")  else {
            return nil
        }
        do {
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            let strings = data.components(separatedBy: .newlines).joined(separator: "\n")
            return strings
        } catch {
            return nil
        }
    }
    
}
