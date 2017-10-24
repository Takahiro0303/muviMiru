import UIKit
import CoreData

class movieSwipe: UIViewController {
    

    //@IBOutlet weak var thumbImage: UIImageView!
    
    //インジケーターのインスタンス化
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var divisor : CGFloat!
    
    var scSelectedIndex = -1
    
    //前ページの情報を引き継ぐ
    var movieplace1 = ""
    
    //URLを配列に保存
    var movieList:[String] = []
    
    //各情報を配列に保存
    var movieTrackName:[String] = []
    var movieLongDescription:[String] = []
    var movieReleaseDate:[String] = []
    var movieTrackViewUrl:[String] = []
    
    //パッケージデータの取得、NSDataの配列
    var movieD:[NSData] = []
    
    //NSデータを保存する数
    var number = 0
    
    //パッケージが何番目かを保存する数
    var num = 0
    
    //コアデータに入れたいデータの保存
    var artWork = ""
    var trackName = ""
    var longDescription = ""
    var releaseDate = ""
    var trackViewUrl = ""
    
//    //userDefaultsインスタンス化
//    let userDefaults = UserDefaults.standard
//    
//    var eigaData:[String] = []
    
    
    //movieデータの空の配列
    let movie:[String] = []
    
    
    //背景のView
        var baseView:UIView = UIView(frame: CGRect(x: 10, y: 80, width: 300, height: 420))

    //写真を置くUIImageViewの作成
        var imageView:UIImageView = UIImageView(frame: CGRect(x: 5, y: 20, width: 290 , height: 390))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
        showIndicator()
        
        //userdefultのデータの取得
        //let name:String? = UserDefaults.standard.object(forKey: "movie") as! String
        //print("ユーザーデフォルト\(name)")
        
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
                    
                    //空データをmovieDに追加
                    movieD.append(NSData())
                    
                    //trackNameの取得
                    let trackName = movieData["trackName"] as! String
                    movieTrackName.append(trackName as! String)
                    //longDescriptionの取得
                    let longDescription = movieData["longDescription"] as! String
                    movieLongDescription.append(longDescription as! String)
                    
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
                            
                            //movieListを検索し、今ダウンロードされたデータがどれか判定、その場所へ保存（順番を一致させる）
                            var index = 0
                            for movietmp in self.movieList{
                                if movietmp == res.url?.absoluteString {
                                    self.movieD[index] = data as! NSData
                                    break
                                }else{
                                    index += 1
                                }
                                
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
        
        
        //１枚目の画像の表示
        let pictureURL = URL(string: movieList[0])!
        
        let sessionSession = URLSession(configuration: .default)
        
        let downloadTask = sessionSession.dataTask(with: pictureURL) { (dataData, response1, error1) in
            if let erer = error1 {
                print("エラー発生 \(erer)")
            } else {
                if let res1 = response1 as? HTTPURLResponse {
                    if let imageData1 = dataData {
                        let imageimageimage = UIImage(data: imageData1)
                        
                        self.viewOn(image: imageimageimage)
                        
                        print("image出たよ!")
                        self.imageView.image = imageimageimage
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    } else {
                        print("画像を取得できませんでした：画像はありません")
                    }
                } else {
                    print("何らかの理由で応答コードを取得できませんでした")
                }
            }
        }
        
        downloadTask.resume()
        
        
        
        artWork = movieList[0]
        
        let movieT = movieTrackName[0]
        trackName = movieT
        print("一番初めの"+trackName)
        
        let movieL = movieLongDescription[0]
        longDescription = movieL
        
        let movieR = movieReleaseDate[0]
        releaseDate = movieR
        
        let movieU = movieTrackViewUrl[0]
        trackViewUrl = movieU
        
    }

    //    新しいカードを作成するメソッド
    func newPage(){
        
        number += 1
        
        viewOn(image:nil)

        
            artWork = movieList[number]
        
            let movieT = movieTrackName[number]
            trackName = movieT
            print("表示されているDVD名"+trackName)
            
            let movieL = movieLongDescription[number]
            longDescription = movieL
        
            let movieR = movieReleaseDate[number]
            releaseDate = movieR
            
            let movieU = movieTrackViewUrl[number]
            trackViewUrl = movieU
    }
 
    
//　　　　gesturePanメソッド
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: card.center.x + (point.x)/4, y: card.center.y + (point.y/4))
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
//        if xFromCenter > 0 {
//            thumbImage.image = #imageLiteral(resourceName: "iThumbsUp")
//            thumbImage.tintColor = UIColor.green
//        }else{
//            thumbImage.image = #imageLiteral(resourceName: "ThumbsDown")
//            thumbImage.tintColor = UIColor.red
//        }
//
//        thumbImage.alpha = abs(xFromCenter) / view.center.x

        
        //指が離れた時に呼ばれる
        if sender.state == UIGestureRecognizerState.ended{
        
            if card.center.x < 75 {
            //左に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center = CGPoint(x: self.view.center.x - 300, y: card.center.y + 75)
                card.alpha = 0
            })
//                if userDefaults.object(forKey: "movie") != nil {
//                    self.eigaData = [userDefaults.object(forKey: "movie") as! String]
//                }
//
//                eigaData.append(artWork)
//                // デフォルト値取得
//                UserDefaults.standard.set(eigaData, forKey: "movie")
//                //userDefaults.synchronize()
                
                
            self.newPage()
            
            return
            }else if card.center.x > (view.frame.width - 75){
            //右に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center.self = CGPoint(x: self.view.center.x + 300, y: card.center.y + 75)
                card.alpha = 0
            })
//                if userDefaults.object(forKey: "movie") != nil {
//                    self.eigaData = [userDefaults.object(forKey: "movie") as! String]
//                }
//
//                eigaData.append(artWork)
//                // デフォルト値取得
//                UserDefaults.standard.set(eigaData, forKey: "movie")
//                //userDefaults.synchronize()
                
            
            //AppDelegateを使う用意をいておく
            let appD:AppDelegate = UIApplication.shared.delegate as!AppDelegate
            
            //エンティティを操作するためのオブジェクトを作成
            let viewContext = appD.persistentContainer.viewContext
            
            //movieエンティティオブジェクトを作成
            let movieData = NSEntityDescription.entity(forEntityName: "Movie", in: viewContext)
            
            //movieエンティティにレコード（行）を購入するためのオブジェクトを作成
            let newRecord = NSManagedObject(entity: movieData!, insertInto: viewContext)
                
            
            //値のセット(アトリビュート毎に指定)forkeyはモデルで指定したアトリビュート名
            newRecord.setValue(artWork, forKey: "artworkUrl")
            newRecord.setValue(releaseDate, forKey: "releaseDate")
            newRecord.setValue(trackName, forKey: "trackName")
            newRecord.setValue(longDescription, forKey: "longDescription")
            newRecord.setValue(trackViewUrl, forKey: "trackViewUrl")
            newRecord.setValue(Date(), forKey: "saveDate")
                print("アートワーク"+artWork)
                print("名前"+trackName)
                print("説明"+longDescription)
                print("日付"+releaseDate)
                print("URL"+trackViewUrl)
                
                
            
            //レコード（行）の即時保存
            //        例外表示の書き方
            do{
                try viewContext.save()
            }catch{
                
            }
                self.newPage()
            return
            }
        
        
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
//                self.thumbImage.alpha = 0
                card.transform = .identity
            })
            
        }
        
    }
    
    func viewOn(image:UIImage?) {
        //背景のView
        var height = self.view.bounds.size.height - 150
        var width = self.view.bounds.size.width - 40
        
        var baseView:UIView = UIView(frame: CGRect(x: 10, y: 80, width: width, height: height))
        
        //写真を置くUIImageViewの作成
        var imageHeight = self.view.bounds.size.height - 180
        var imageWidth = self.view.bounds.size.width - 50
        
        var imageView:UIImageView = UIImageView(frame: CGRect(x: 5, y: 20, width: imageWidth , height: imageHeight))
        
        //noimageの写真を置く
        var imageView1:UIImageView = UIImageView(frame: CGRect(x: 5, y: 20, width: imageWidth , height: imageHeight))
        
        
        //baseView(カード)の色をつける
        baseView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        //画像の表示を可能にするコード
        imageView.isUserInteractionEnabled = true
        
        if image != nil {
            imageView.image = image
        }
        
        // baseViewの上にmyPictureを乗せる
        baseView.addSubview(imageView)
        
        //スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        //baseViewにジェスチャーを登録
        baseView.addGestureRecognizer(Pan)
        
        
        if movieD.count > 0 {
            let movieA = movieD[number] as! NSData
            if movieA != NSData() {
                //パッケージの出力
                let imageimage = UIImage(data: movieA as Data)
                imageView.image = imageimage
            }else{
                //imageView1.image = (image:#imageLiteral(resourceName: "noimage.png")) as? UIImage
            }
        }
        
        
        
        
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = false
        baseView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        baseView.layer.shadowOpacity = 0.5 // 透明度
        baseView.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView.layer.shadowRadius = 5 // ぼかし量
        
        //viewの上にbaseViewを乗せる
        self.view.addSubview(baseView)
        
        baseView.center.x = self.view.center.x

        
    }

    
    //インジケータースタート
    func showIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
