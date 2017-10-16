import UIKit
import CoreData

class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var myTextView: UITableView!
    
    var contentTitle:[String] = []
    //var contentArtWork:[NSData] = []
    var saveDate:[Date] = []
    
    var selectedIndex =  -1 //選択された行番号
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        read()
        //myTextView.reloadData()
    }
    
    //    CoreDateに保存されているデータの読み込み（READ）
    func read(){
        
        contentTitle = []
        saveDate = []
        
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
                var title:String? = result.value(forKey:"trackName") as? String
                //var artWork:String? = result.value(forKey:"artworkUrl") as? String
                var saveSaveDate:Date? = result.value(forKey: "saveDate") as? Date
                print("セーブデータ\(saveSaveDate)")
//                let catPictureURL = URL(string: artWork!)
//                let session = URLSession(configuration: .default)
//                let downloadPicTask = session.dataTask(with: catPictureURL!) { (data, response, error) in
//                    if let e = error {
//                        print("cat pictureのダウンロード中にエラーが発生しました: \(e)")
//                    } else {
//                       if let res = response as? HTTPURLResponse {
//                        print("レスポンスコード付き画像ダウンロード \(res.statusCode)")
//                            if let imageData = data {
//                            self.contentArtWork.append(data as! NSData)
//                            }
//                        }
//                        }
//                                                                            }
//
//                downloadPicTask.resume()

                
                
                contentTitle.append(title as! String)
                saveDate.append(saveSaveDate as! Date)
                
                
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
        //cell.movieLavel?.text = contentTitle[indexPath.row]
//        let imageimage = UIImage(data: contentArtWork[indexPath.row] as Data)
//        cell.movieImage?.image = imageimage
//
        cell.textLabel?.text = contentTitle[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
    
    //セルをスワイプした時にdeleteされる
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let action = UITableViewRowAction(style: .default,title: "削除"){action, index in
        
            //AppDelegateを使う用意をしておく
            let appD:AppDelegate = UIApplication.shared.delegate as!AppDelegate
            
            //エンティティを操作するためのオブジェクトを使用
            let viewContext = appD.persistentContainer.viewContext
            
            //どのエンティティからデータを取得してくるか設定
            let query:NSFetchRequest<Movie> = Movie.fetchRequest()
            
            //絞り込み検索、指定した日付とsaveDataが一致するデータを取得
            let namePredicte = NSPredicate(format: "saveDate = %@", self.saveDate[indexPath.row] as CVarArg)
            query.predicate = namePredicte
            
            //データを一括取得
            do{
                let fetchRequests = try viewContext.fetch(query)
                
                for result:AnyObject in fetchRequests{
                    //取得したデータを指定し、削除
                    let record = result as! NSManagedObject
                    //print("削除されました")
                    viewContext.delete(record)
                }
                
                //削除した状態を保存
                try viewContext.save()
            }catch{
                print("削除失敗")
            }
            
            self.read()
            self.myTextView.reloadData()
        }
        
        return[action]
    }
    

    
    //        セグエを使って画面を移動しようとしている時発動するメソッド
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dv:movieDetail = segue.destination as! movieDetail
        //saveDataの保存
        dv.scSelectedDate = saveDate[selectedIndex]
        //        作成しておいたプロパティー（メンバ変数）に行番号を保存
        dv.scSelectedIndex = selectedIndex
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

