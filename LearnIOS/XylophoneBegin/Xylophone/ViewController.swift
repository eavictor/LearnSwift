//
//  ViewController.swift
//  Xylophone
//
//  Created by appsgaga on 2018/9/19.
//  Copyright © 2018 appsgaga. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioMetrix:[AVAudioPlayer?] = []
    
    func genAudioPlayers() {
        for index in 0...7 {
            guard let path:String = Bundle.main.path(forResource: "\(index+1)", ofType: "mp3") else {
                print("Resource not found.")
                return
            }
            let url = URL(fileURLWithPath: path)
            do {
                let audioPlayer:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                audioMetrix.append(audioPlayer)
            } catch {
                audioMetrix.append(nil)
            }
        }
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        let player:AVAudioPlayer? = audioMetrix[sender.tag-1]
        player?.stop()
        player?.currentTime = 0
        player?.play()
        print("play \(sender.tag)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        genAudioPlayers()
    }


}

