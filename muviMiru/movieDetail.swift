//
//  showDetail.swift
//  sampleTeaList
//
//  Created by takahiro tshuchida on 2017/09/07.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit
import CoreData
//import SDWebImage

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
        read()
        print("\(scSelectedIndex)行目が押されて移動してきました")
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(movieDetail.urlTap(_:)))
        textUrl.addGestureRecognizer(tapGestureRecognizer)
        textUrl.isUserInteractionEnabled = true
        
    }
    
    //    CoreDateに保存されているデータの読み込み（READ）
    func read(){
        //AppDelegateを使う用意をしておく
        let appD:AppDelegate = UIApplication.shared.delegate as!AppDelegate
        
        //エンティティを操作するためのオブジェクトを使用
        let viewContext = appD.persistentContainer.viewContext
        
        //どのエンティティからデータを取得してくるか設定
        let query:NSFetchRequest<Movie> = Movie.fetchRequest()
        
        //絞り込み検索、指定した日付とsaveDataが一致するデータを取得
        let namePredicte = NSPredicate(format: "saveDate = %@", scSelectedDate as CVarArg)
        query.predicate = namePredicte
        
        //データ一括取得
        do{
            //保存されているデータを全て(fetch)取得
            let fetchResults = try viewContext.fetch(query)
            
            //データの取得
            for result: AnyObject in fetchResults{
                let title:String? = result.value(forKey: "trackName") as? String
                let description:String? = result.value(forKey:"longDescription") as? String
                let releaseDate:String? = result.value(forKey: "releaseDate") as? String
                let trackUrl:String? = result.value(forKey: "trackViewUrl") as? String
                let artWork:String? = result.value(forKey:"artworkUrl") as? String
                
//                let imageURL = URL(string: artWork)
//
//                myImageView.sd_setImage(with: imageURL)
                
                let catPictureURL = URL(string: artWork!)
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: catPictureURL!) { (data, response, error) in
                    if let e = error {
                        print("pictureのダウンロード中にエラーが発生しました: \(e)")
                    } else {
                       if let res = response as? HTTPURLResponse {
                        print("レスポンスコード付き画像ダウンロード \(res.statusCode)")
                            if let imageData = data {
                                let imageimage = UIImage(data: imageData)
                                print(imageimage!)
                                self.myImageView.image = imageimage
                            }
                        }
                        }                                                                                            }
                
                    downloadPicTask.resume()
                
                
                
                textName.text = title!
                textUrl.text = trackUrl!
                myTextView.text = description!
                textRelease.text = releaseDate!
                
                
                
                }
                }catch{
            }
            
        }
    
    
    //urlがタップされたら
    @IBAction func urlTap(_ sender: Any) {
        if let url = NSURL(string: textUrl as! String){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
