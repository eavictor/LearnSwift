//
//  ViewController.swift
//  HelloDownloadImage
//
//  Created by eavictor on 2020/12/28.
//

import UIKit

class ViewController: UIViewController {
    
    var session:URLSession?
    
    let imageAddress:String = "https://i.imgur.com/rDbxVim.jpeg"

    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = URLSession(configuration: URLSessionConfiguration.default)
        if let imageURL:URL = URL(string: imageAddress) {
//            let task = session?.dataTask(with: imageURL, completionHandler: {
//                (data:Data?, response:URLResponse?, error:Error?) in
//                if error != nil {
//                    print(error!.localizedDescription)
//                    return  // escape
//                }
//                if let loadedData = data {
//                    let loadedImage = UIImage(data: loadedData)
//                    DispatchQueue.main.async {
//                        self.myImageView.image = loadedImage
//                    }
//                }
//            })
//            task?.resume()
            let downloadTask = session?.downloadTask(with: imageURL, completionHandler: {
                (url:URL?, response:URLResponse?, error:Error?) in
                if error != nil {
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009 {
                        print("No internet connection")
                    }
                    print(error!.localizedDescription)
                    return
                }
                if let loadedURL = url {
                    do {
                        let data = try Data(contentsOf: loadedURL)
                        let loadedImage = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.myImageView.image = loadedImage
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            })
            downloadTask?.resume()
//            DispatchQueue.global().async {
//                do {
//                    let imageData = try Data(contentsOf: imageURL)
//                    let downloadImage = UIImage(data: imageData)
//                    DispatchQueue.main.async {
//                        self.myImageView.image = downloadImage
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
        }
    }
}
