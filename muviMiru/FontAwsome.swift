
import Foundation
import FontAwesome_swift
import UIKit


class FontAwsome: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].image = UIImage.fontAwesomeIcon(name: .info, textColor: UIColor.green, size: CGSize (width: 30, height: 30))
        self.tabBar.items![1].image = UIImage.fontAwesomeIcon(name: .film, textColor: UIColor.green, size: CGSize (width: 30, height: 30))
        self.tabBar.items![2].image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.green, size: CGSize (width: 30, height: 30))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

