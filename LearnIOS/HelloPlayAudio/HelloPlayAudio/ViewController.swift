//
//  ViewController.swift
//  HelloPlayAudio
//
//  Created by eavictor on 2020/12/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer?

    @IBAction func play(_ sender: UIButton) {
        // Stop playing audio
        audioPlayer?.stop()
        // Reset time frame to start
        audioPlayer?.currentTime = 0
        // Play audio
        audioPlayer?.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Find mp3 file path
        guard let audioPath = Bundle.main.path(forResource: "たぬきちの冒険", ofType: "mp3") else {
            print("No such file")
            return
        }
        
        let url = URL(fileURLWithPath: audioPath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
    }


}

