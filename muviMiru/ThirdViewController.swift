//
//  ViewController.swift
//  sampleTeaList
//
//  Created by takahiro tshuchida on 2017/09/07.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var myTextView: UITableView!
    
    
    var teaList = ["ダージリン","アールグレイ","アッサム","オレンジペコ"]
    
    //    引き渡し用の変数
    var teaFild = ""
    var teaImage = UIImage()
    
    var selectedIndex =  -1 //選択された行番号
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //２.行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teaList.count
    }
    
    //３.リストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字を表示するセルの取得（セルの再利用）
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //表示したい文字の設定 indexPath.rowが行番号を表す
        cell.textLabel?.text = teaList[indexPath.row]
        cell.textLabel?.textColor = UIColor.brown
        cell.accessoryType = .disclosureIndicator
        //文字を設定したセルを返す
        return cell
    }
    
    //    セルがダップされた時、segueを使って画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            teaFild = "ダ"
            
        }else if indexPath.row == 1 {
            teaFild = "ア"
        }else if indexPath.row == 2 {
            teaFild = "アッ"
        }else{
            teaFild = "オ"
            
        }
        
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
        
        dv.teaFild1 = teaFild
        dv.teaImage1 = teaImage
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

