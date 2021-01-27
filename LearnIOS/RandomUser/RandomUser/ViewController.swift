//
//  ViewController.swift
//  RandomUser
//
//  Created by eavictor on 2020/12/29.
//

import UIKit
import AudioToolbox

struct User {
    var name:String?
    var email:String?
    var phone:String?
    var image:String?
}

// json parsing new method since swift 4
struct AllData:Decodable {
    var results:[SingleData]?
}
struct SingleData:Decodable {
    var name:Name?
    var email:String?
    var phone:String?
    var picture:Picture?
}
struct Name:Decodable {
    var first:String?
    var last:String?
}
struct Picture:Decodable {
    var large:String?
}

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    var infoTableViewController:InfoTableViewController?
    var apiAddress:String = "https://randomuser.me/api/"
    var urlSession:URLSession = URLSession(configuration: URLSessionConfiguration.default)
    var isDownloading:Bool = false
    
    @IBAction func makeNewUser(_ sender: Any) {
        if !isDownloading {
            downloadInfo(webAddress: apiAddress)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadInfo(webAddress: apiAddress)
    }
    
    func downloadInfo(webAddress:String) {
        if let url:URL = URL(string: webAddress) {
            let task = urlSession.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil {
                    let errorCode:Int = (error! as NSError).code
                    if errorCode == -1009 {
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "No internet connection")
                        }
                        self.isDownloading = false
                        return
                    } else {
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Sorry")
                        }
                        self.isDownloading = false
                        return
                    }
                }
                if let loadedData = data {
                    do {
                        let okData:AllData = try JSONDecoder().decode(AllData.self, from: loadedData)
                        let firstName = okData.results?[0].name?.first
                        let lastName = okData.results?[0].name?.last
                        let fullName:String? = {
                            guard let okFirstName = firstName, let okLastName = lastName else {return nil}
                            return okFirstName + " " + okLastName
                        }()
                        let email = okData.results?[0].email
                        let phone = okData.results?[0].phone
                        let picture = okData.results?[0].picture?.large
                        let aUser = User(name: fullName, email: email, phone: phone, image: picture)
                        DispatchQueue.main.async {
                            self.settingInfo(user: aUser)
                        }
                    } catch {
                        print(error.localizedDescription)
                        self.isDownloading = false
                    }
                }
            }
            isDownloading = true
            task.resume()
            isDownloading = false
        }
    }
    
    func popAlert(withTitle title:String) {
        let alert:UIAlertController = UIAlertController(title: title, message: "Please try again later", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            infoTableViewController = segue.destination as? InfoTableViewController
        }
    }
    
    func settingInfo(user:User) {
        username.text = user.name
        infoTableViewController?.phoneLabel.text = user.phone
        infoTableViewController?.emailLabel.text = user.email
        let imageAddress = user.image
        if let okImageAddress = imageAddress {
            if let imageURL = URL(string: okImageAddress) {
                let task = urlSession.downloadTask(with: imageURL) {
                    (url:URL?, response:URLResponse?, error:Error?) in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Something went wrong")
                        }
                        return
                    }
                    if let okURL = url {
                        do {
                            let data = try Data(contentsOf: okURL)
                            let downloadImage = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.userImage.image = downloadImage
                                AudioServicesPlaySystemSound(1000)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.popAlert(withTitle: "Image conversion error")
                            }
                        }
                    
                    }
                }
                isDownloading = true
                task.resume()
                isDownloading = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
    }
}

