//
//  ViewController.swift
//  sampleTeaList
//
//  Created by takahiro tshuchida on 2017/09/07.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var myTextView: UITableView!
    
    
    var contentTitle:[String] = []
    var contentArtWork:[String] = []
    var contentDescription:[String] = []
    var contentRelease:[String] = []
    var contentTime:[Int] = []
    var contentUrl:[String] = []
    var selectedIndex =  -1 //選択された行番号
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        read()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    CoreDateに保存されているデータの読み込み（READ）
    func read(){
        //AppDelegateを使う用意をしておく
        let appD:AppDelegate = UIApplication.shared.delegate as!AppDelegate
        
        //エンティティを操作するためのオブジェクトを使用
        let viewContext = appD.persistentContainer.viewContext
        
        
        //どのエンティティからデータを取得してくるか設定
        let query:NSFetchRequest<Movie> = Movie.fetchRequest()
        
        //データ一括取得
        do{
            //保存されているデータを全て(fetch)取得
            let fetchResults = try viewContext.fetch(query)
            
            //一件ずつ表示
            for result:AnyObject in fetchResults{
                let title:String? = result.value(forKey:"trackName") as? String
                let artWork:String? = result.value(forKey:"artworkUrl") as? String
                let longDescription:String? = result.value(forKey:"longDescription") as? String
                let releaseDate:String? = result.value(forKey:"releaseDate") as? String
                let trackTimeMillis:Int? = result.value(forKey:"trackTimeMillis") as? Int
                let trackViewUrl:String? = result.value(forKey:"trackViewUrl") as? String
                
                
                print("title:\(title!)")
                
                contentTitle.append(title as! String)
                contentArtWork.append(artWork as! String)
                contentDescription.append(longDescription as! String)
                contentRelease.append(releaseDate as! String)
                contentTime.append(trackTimeMillis as! Int)
                contentUrl.append(trackViewUrl as! String)
                
                
            }
        }catch{
        }
    }

    
    //２.行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentTitle.count
    }
    
    //３.リストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字を表示するセルの取得（セルの再利用）
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //表示したい文字の設定 indexPath.rowが行番号を表す
        cell.textLabel?.text = contentTitle[indexPath.row]
        cell.textLabel?.textColor = UIColor.brown
        cell.accessoryType = .disclosureIndicator
        //文字を設定したセルを返す
        return cell
    }
    
    //    セルがダップされた時、segueを使って画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        選択された行番号を保存
        selectedIndex = indexPath.row
        
        //        セグエを指定して、画面遷移
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    
    
    
    //        セグエを使って画面を移動しようとしている時発動するメソッド
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        prepareの中では、移動元の画面、移動先の画面、どちらも操作が可能
        //        移動先の画面に渡したい情報をセットできる
        //        dv　今から移動する画面のオブジェクト（インスタンス）
        //        segue.destination セグエを使って移動する先
        //        as ダウンキャスト変換するための記号
        
        let dv:movieDetail = segue.destination as! movieDetail
        
        //        作成しておいたプロパティー（メンバ変数）に行番号を保存
        dv.scSelectedIndex = selectedIndex
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

