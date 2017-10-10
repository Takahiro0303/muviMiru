
import Foundation
import FontAwesome_swift
import UIKit


class FontAwsome: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].image = UIImage.fontAwesomeIcon(name: .film, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), size: CGSize (width: 30, height: 30))
        self.tabBar.items![1].image = UIImage.fontAwesomeIcon(name: .user, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), size: CGSize (width: 30, height: 30))
        
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
    guard let tabContent = viewController as? UINavigationController else {
    return true
    }
    let navigationContent = tabContent.viewControllers[0]
    if nil != navigationContent as? SecondViewController {
    // Bの時だけ選択色を赤に
    tabBar.tintColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    } else {
    // それ以外は緑に
    tabBar.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
    return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

