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
                let releaseDate:Data? = result.value(forKey: "releaseDate") as? String
                let trackUrl:Data? = result.value(forKey: "trackViewUrl") as? String
                let artWork:String? = result.value(forKey:"artworkUrl") as? String
                
                
                textName.text = title!
                textUrl.text = trackUrl!
                myTextView.text = description!
                textRelease.text = releaseDate!
                myImageView.image = artWork
                
                
                
            }
        }catch{
        }
            
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
