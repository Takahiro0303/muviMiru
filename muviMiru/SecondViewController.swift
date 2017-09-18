//
//  SecondViewController.swift
//  muviMiru
//
//  Created by takahiro tshuchida on 2017/09/17.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var proArray = ["アクション","SF","コメディー","サスペンス","ミステリー","ホラー","スポーツ"]
    
    var selectedIndex =  -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return proArray.count
        }
        
        //３.リストに表示する文字列を決定し、表示
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //文字を表示するセルの取得（セルの再利用）
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            //表示したい文字の設定 indexPath.rowが行番号を表す
            cell.textLabel?.text = proArray[indexPath.row]
            cell.textLabel?.textColor = UIColor.brown
            cell.accessoryType = .disclosureIndicator
            
            
            //文字を設定したセルを返す
            return cell
        }
        
        //    セルがダップされた時、segueを使って画面遷移
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("\(indexPath.row)行目がタップタップされました")
            
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
            
            let dv:movieSwipeViewController = segue.destination as! movieSwipeViewController
            
            //        作成しておいたプロパティー（メンバ変数）に行番号を保存
            dv.scSelectedIndex = selectedIndex
            
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

