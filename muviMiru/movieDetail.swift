//
//  showDetail.swift
//  sampleTeaList
//
//  Created by takahiro tshuchida on 2017/09/07.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit
import CoreData

class movieDetail: UIViewController {
    
    var scSelectedIndex = -1
    
    var scSelectedDate : Date = Date()
    
    
    
    @IBOutlet weak var myTextView: UITextView!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var textRelease: UITextField!
    
    @IBOutlet weak var textUrl: UITextField!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(scSelectedIndex)行目が押されて移動してきました")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
