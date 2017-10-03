import UIKit
import CoreData

class movieSwipe: UIViewController {
    
    var scSelectedIndex = -1
    
    //前ページの情報を引き継ぐ
    var movieplace1 = ""
    
    //URLを配列に保存
    var movieList:[String] = []
    
    //各情報を配列に保存
    var movieTrackName:[String] = []
    var movieLongDescription:[String] = []
    //var movietrackTimeMillis:[Int] = []
    var movieReleaseDate:[String] = []
    var movieTrackViewUrl:[String] = []
    
    
    
    //パッケージデータの取得、NSDataの配列
    var movieD:[NSData] = []
    
    //NSデータを保存する数
    var number = 0
    
    //パッケージが何番目かを保存する数
    var num = 0
    
    var movieArt:[NSData] = []
    var movieTrack:[String] = []
    var movieLongD:[String] = []
    var movieRel:[String] = []
    var movieTrackU:[String] = []
    
    var flag2:[String] = []
    
    //インジケーターの作成
    private var myActivityIndicator: UIActivityIndicatorView!
    
    //背景のView
    var baseView:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 270))
    
    //写真を置くUIImageViewの作成
    var imageView:UIImageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 227, height: 227))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // インジケータを作成する.
        //        myActivityIndicator = UIActivityIndicatorView()
        //        //myActivityIndicator.frame = CGRectMake(0, 0, 50, 50)
        //        myActivityIndicator.center = self.view.center
        //
        //        // アニメーションを開始する.
        //        myActivityIndicator.startAnimating()
        //
        //
        //        // インジケータをViewに追加する.
        //        self.view.addSubview(myActivityIndicator)
        
        
        //baseView(カード)の色をつける
        baseView.backgroundColor = UIColor.darkGray
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 10)
        
        
        self.view.addSubview(baseView)
        
        
        
        //        スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        //        baseViewにジェスチャーを登録
        self.baseView.addGestureRecognizer(Pan)
        
        //画像の表示を可能にするコード
        imageView.isUserInteractionEnabled = true
        
        // baseViewの上にmyPictureを載せる
        self.baseView.addSubview(imageView)
        
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = false
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.5 // 透明度
        baseView.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView.layer.shadowRadius = 5 // ぼかし量
        
        //iTunesのAPIからデータ取得
        //URLを指定して、インターネット経由で取得
        var url = URL(string: movieplace1)
        
        
        //インターネットに接続するためのリクエストを作成
        var request = URLRequest(url: url!)
        
        //JSONデータをData型で取得
        let jasondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        
        //辞書データに変換
        let jsonDic = (try! JSONSerialization.jsonObject(with: jasondata, options: [])) as! NSDictionary
        
        //取得したデータ数だけ繰り返して表示
        for(key,data) in jsonDic{
           //print("key:\(key) Data:\(data)")
            
            let keys = key as! String
            
            if keys == "results" {
                
                let movie : NSArray = data as! NSArray
                for a in movie{
                    
                    let movieData =  a as! NSDictionary
                    
                    //パッケージの取得
                    let artworkUrl = movieData["artworkUrl100"] as! String
                    //画質を400×400にする
                    var replaced = artworkUrl.replacingOccurrences(of: "100x100", with: "400x400") as! String
                    //配列に入れ込む
                    movieList.append(replaced as! String)
                    
                    //trackNameの取得
                    let trackName = movieData["trackName"] as! String
                    movieTrackName.append(trackName as! String)
                    //longDescriptionの取得
                    let longDescription = movieData["longDescription"] as! String
                    movieLongDescription.append(longDescription as! String)
                    
//                    if movieData["trackTimeMills"] != nil{
//                        //trackTimeMillsの取得
//                        let trackTimeMillis = movieData["trackTimeMillis"] as! Int
//                        movietrackTimeMillis.append(trackTimeMillis as! Int)
//                    }
                    
                    //releaseDataの取得
                    let releaseDate = movieData["releaseDate"] as! String
                    movieReleaseDate.append(releaseDate as! String)
                    //trackViewUrlの取得
                    let trackViewUrl = movieData["trackViewUrl"] as! String
                    movieTrackViewUrl.append(trackViewUrl as! String)
                }
            }
        }
        
        //URLから画像の表示
        //初めに表示されるパッケージ
        //movieListにあるURLの数だけfor文で回す
        for movie in movieList {
            let catPictureURL = URL(string: movie)!
            
            let session = URLSession(configuration: .default)
            
            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            
                if let e = error {
                    print("cat pictureのダウンロード中にエラーが発生しました: \(e)")
                } else {
                  
                    if let res = response as? HTTPURLResponse {
                        print("レスポンスコード付きダウンロード \(res.statusCode)")
                        if let imageData = data {
                            self.movieD.append(data as! NSData)
                            
                            if self.movieD.count == 1 {
                                
                                let imageimage = UIImage(data: imageData)
                                print(imageimage!)
                                self.imageView.image = imageimage
                                
                            }
                        } else {
                            print("画像を取得できませんでした：画像はありません")
                        }
                    } else {
                        print("何らかの理由で応答コードを取得できませんでした")
                    }
                }
            }
            
            downloadPicTask.resume()
            
        }
    }

    //    新しいカードを作成するメソッド
    func newPage(){
        //背景のView
        var baseView:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 270))
        
        //写真を置くUIImageViewの作成
        var imageView:UIImageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 227, height: 227))
        
        //baseView(カード)の色をつける
        baseView.backgroundColor = UIColor.darkGray
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 10)
        
        self.view.addSubview(baseView)
        
        // baseViewの上にmyPictureを載せる
        self.baseView.addSubview(imageView)
        
        
        //スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        //baseViewにジェスチャーを登録
        baseView.addGestureRecognizer(Pan)
        
        //画像の表示を可能にするコード
        imageView.isUserInteractionEnabled = true
        
        //baseViewの上にmyPictureを載せる
        baseView.addSubview(imageView)
        
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = false
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.5 // 透明度
        baseView.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView.layer.shadowRadius = 5 // ぼかし量
        
        number += 1
        //var movieTime = 0
        let movieA = movieD[number] as! NSData
        movieArt.append(movieA as! NSData)
        let movieT = movieTrackName[number]
        movieTrack.append(movieT as! String)
        let movieL = movieLongDescription[number]
        movieLongD.append(movieL as! String)
//        if movietrackTimeMillis[number] != nil{
//        let movieTime = movietrackTimeMillis[number]
//        }
        let movieR = movieReleaseDate[number]
        movieRel.append(movieR as! String)
        let movieU = movieTrackViewUrl[number]
        movieTrackU.append(movieU as! String)
        
        if movieA != nil {
            //パッケージの出力
            let imageimage = UIImage(data: movieA as Data)
            print(imageimage!)
            imageView.image = imageimage
        }
    }
 
    func panAction(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        //print("move")
        
//        if xFromCenter > 0 {
//            thumbImage.image = #imageLiteral(resourceName: "iThumbsUp")
//            thumbImage.tintColor = UIColor.green
//        }else{
//            thumbImage.image = #imageLiteral(resourceName: "ThumbsDown")
//            thumbImage.tintColor = UIColor.red
//        }
//
//        thumbImage.alpha = abs(xFromCenter) / view.center.x
        
        if card.center.x < 75 {
            //左に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center = CGPoint(x: self.view.center.x - 200, y: card.center.y + 75)
                card.alpha = 0
            })
            self.newPage()
            return
        }else if card.center.x > (view.frame.width - 75){
            //右に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center.self = CGPoint(x: self.view.center.x + 200, y: card.center.y + 75)
                card.alpha = 0
            })
            //AppDelegateを使う用意をいておく
            let appD:AppDelegate = UIApplication.shared.delegate as!AppDelegate
            
            //エンティティを操作するためのオブジェクトを作成
            let viewContext = appD.persistentContainer.viewContext
            
            //movieエンティティオブジェクトを作成
            let movieData = NSEntityDescription.entity(forEntityName: "Movie", in: viewContext)
            
            //movieエンティティにレコード（行）を購入するためのオブジェクトを作成
            let newRecord = NSManagedObject(entity: movieData!, insertInto: viewContext)
            
            
            //値のセット(アトリビュート毎に指定)forkeyはモデルで指定したアトリビュート名
            newRecord.setValue(movieArt, forKey: "artworkYrl")
            //newRecord.setValue(movieTime, forKey: "trackTimeMillis")
            newRecord.setValue(movieRel, forKey: "releaseDate")
            newRecord.setValue(movieTrack, forKey: "trackName")
            newRecord.setValue(movieLongD, forKey: "longDesciption")
            newRecord.setValue(movieTrackU, forKey: "trackViewUrl")
            
            //レコード（行）の即時保存
            //        例外表示の書き方
            do{
                try viewContext.save()
            }catch{
                
            }

            
            self.newPage()
            return
        }
        
        //指が離れた時に呼ばれる
        if sender.state == UIGestureRecognizerState.ended{
            
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
//                self.thumbImage.alpha = 0
            })
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
