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
        //print("\(scSelectedIndex)行目が押されて移動してきました")
        animateImage(target: myImageView)
        

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
                var releaseDate:String? = result.value(forKey: "releaseDate") as? String
                let trackUrl:String? = result.value(forKey: "trackViewUrl") as? String
                let artWork:String? = result.value(forKey:"artworkUrl") as? String
                
                
                //映画リリース日に含まれる余分な文字を取り除く
                var replaced = releaseDate?.replacingOccurrences(of: "T", with: "") as! String
                var replaced1 = replaced.replacingOccurrences(of: "Z", with: "") as! String
                
                //日付データの取得
                let format:DateFormatter = DateFormatter()
                format.dateFormat = "yyyy-MM-ddhh:mm:ss"
                let movieTime = format.date(from: replaced1)

                let format1:DateFormatter = DateFormatter()
                format1.dateFormat = "yyyy/MM/dd"
                let movieDate = format1.string(from: movieTime as! Date)

                
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
                
                
                //各情報の出力
                textName.text = title!
                textUrl.text = trackUrl!
                myTextView.text = description!
                textRelease.text = movieDate
                
                
                
                }
                }catch{
            }
            
        }
    
    
    //urlがタップされたら
    @IBAction func urlTap(_ sender: Any) {
        if let url = NSURL(string: textUrl.text!){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    //画像を左から右にアニメイトする
    func animateImage(target:UIView){
        // 画面1pt進むのにかかる時間の計算
        let timePerSecond = 15.0 / view.bounds.size.width
        
        // 画像の位置から画面右までにかかる時間の計算
        let remainTime = (view.bounds.size.width - target.frame.origin.x) * timePerSecond
        
        // アニメーション
        UIView.transition(with: target, duration: TimeInterval( remainTime), options: .curveLinear, animations: { () -> Void in
            
            // 画面右まで移動
            target.frame.origin.x = self.view.bounds.width
            
        }, completion: { _ in
            
            // 画面右まで行ったら、画面左に戻す
            target.frame.origin.x = -target.bounds.size.width
            
            // 再度アニメーションを起動
            self.animateImage(target: target)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
