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
    
    var proArray = ["アクション","SF/ファンタジー","ロマンス","コメディー","ミュージカル","ホラー","ドキュメンタリー","ドラマ","キッズファミリー","アニメ","スポーツ","日本映画"]
    
    var selectedIndex =  -1
    
    var movieplace = ""
    
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
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.accessoryType = .disclosureIndicator
            
            
            //文字を設定したセルを返す
            return cell
        }
        
        //    セルがダップされた時、segueを使って画面遷移
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("\(indexPath.row)行目がタップタップされました")
            
            if indexPath.row == 0 {
             movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%82%a2%e3%82%af%e3%82%b7%e3%83%a7%e3%83%b3&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 1 {
              movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=SF&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 2 {
            movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%83%ad%e3%83%9e%e3%83%b3%e3%82%b9&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 3 {
            movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%82%b3%e3%83%a1%e3%83%87%e3%82%a3&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 4 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%83%9f%e3%83%a5%e3%83%bc%e3%82%b8%e3%82%ab%e3%83%ab&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 5 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%83%9b%e3%83%a9%e3%83%bc&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 6 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%83%89%e3%82%ad%e3%83%a5%e3%83%a1%e3%83%b3%e3%82%bf%e3%83%aa%e3%83%bc&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 7 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%83%89%e3%83%a9%e3%83%9e&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 8 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%82%ad%e3%83%83%e3%82%ba&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else if indexPath.row == 9 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%82%a2%e3%83%8b%e3%83%a1&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            }else if indexPath.row == 10 {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e3%82%b9%e3%83%9d%e3%83%bc%e3%83%84&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
            } else {
                movieplace = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=%e6%97%a5%e6%9c%ac%e6%98%a0%e7%94%bb&media=movie&entity=movie&attribute=descriptionTerm&country=jp&limit=200"
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
            
            let dv:movieSwipe = segue.destination as! movieSwipe
            
            //        作成しておいたプロパティー（メンバ変数）に行番号を保存
            dv.scSelectedIndex = selectedIndex
            dv.movieplace1 = movieplace
            
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

