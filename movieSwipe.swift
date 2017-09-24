import UIKit

class movieSwipe: UIViewController {
    
    var scSelectedIndex = -1
    
    var movieplace1 = ""
    
    var movieList:[String] = []
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thumbImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //iTunesのAPIからデータ取得
        //URLを指定して、インターネット経由で取得
        var url = URL(string: movieplace1)
        
        
        //インターネットに接続するためのリクエストを作成
        var request = URLRequest(url: url!)
        
        //JSONデータをData型で取得
        var jasondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        
        //辞書データに変換
        let jsonDic = (try! JSONSerialization.jsonObject(with: jasondata, options: [])) as! NSDictionary
        
        //取得したデータ数だけ繰り返して表示
        for(key,data) in jsonDic{
            //           print("key:\(key) Data:\(data)")
            
            let keys = key as! String
            
            if keys == "results" {
                
                let movie : NSArray = data as! NSArray
                for a in movie{
                    
                    let movieData =  a as! NSDictionary
                    
                    let artworkUrl = movieData["artworkUrl100"] as! String
                    
                    //print(" Data: \(artworkUrl)")
                    movieList.append(artworkUrl as! String)
                    
                }
            }
            
        }
        
        print(movieList)
        
        
        //URLから画像の表示
        let catPictureURL = URL(string: movieList[0])!
        
        /*
         
         デフォルト設定でセッションオブジェクトを作成する。
         
         　*/
        
        let session = URLSession(configuration: .default)
        /*
         
         ダウンロードタスクを定義します。ダウンロードタスクは、
         URLの内容をデータオブジェクトとしてダウンロードし、
         そのデータで望むことを実行できます。
         
         */
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            /*
             ダウンロードが完了しました。
             */
            
            if let e = error {
                print("cat pictureのダウンロード中にエラーが発生しました: \(e)")
            } else {
                /*
                 エラーは見つかりませんでした。
                 レスポンスがないと変わってしまいますので、それもチェックしてください。
                 */
                if let res = response as? HTTPURLResponse {
                    print("レスポンスコード付きダウンロード \(res.statusCode)")
                    if let imageData = data {
                        /*
                         最後に、そのデータをイメージに変換し、
                         それを使って望むことをします。
                         */
                        
                        let imageimage = UIImage(data: imageData)
                        print(imageimage!)
                        self.imageView.image = imageimage
                        
                        /*
                         あなたのイメージで何かをしてください。
                         */
                        
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
    
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        print("動くよ")
        
        if xFromCenter > 0 {
            thumbImage.image = #imageLiteral(resourceName: "iThumbsUp")
            thumbImage.tintColor = UIColor.green
        }else{
            thumbImage.image = #imageLiteral(resourceName: "ThumbsDown")
            thumbImage.tintColor = UIColor.red
        }
        
        thumbImage.alpha = abs(xFromCenter) / view.center.x
        
        if card.center.x < 75 {
            //左に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center = CGPoint(x: self.view.center.x - 200, y: card.center.y + 75)
                card.alpha = 0
            })
            return
        }else if card.center.x > (view.frame.width - 75){
            //右に消える
            UIView.animate(withDuration: 0.3, animations: {
                card.center.self = CGPoint(x: self.view.center.x + 200, y: card.center.y + 75)
                card.alpha = 0
            })
            return
        }
        
        if sender.state == UIGestureRecognizerState.ended{
            
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
                self.thumbImage.alpha = 0
            })
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

