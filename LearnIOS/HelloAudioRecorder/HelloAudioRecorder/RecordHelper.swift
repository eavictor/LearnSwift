//
//  RecordHelper.swift
//  HelloAudioRecorder
//
//  Created by eavictor on 2020/12/20.
//

import Foundation
import AVFoundation

class RecordHelper: NSObject, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder?
    var audioPlayer:AVAudioPlayer?
    var isRecording:Bool = false
    
    func recordAudio() {
        settingAudioSession(toMode: .record)
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        settingAudioSession(toMode: .play)
    }
    
    func playRecordedSound() {
        if !isRecording {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            audioPlayer?.play()
        }
    }
    
    func stopPlaying() {
        if !isRecording {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
    }
    
    func settingAudioSession(toMode mode: AudioSessionMode) {
        audioPlayer?.stop()
        let session = AVAudioSession.sharedInstance()
        do {
            switch mode {
            case AudioSessionMode.record:
                try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            case AudioSessionMode.play:
                try session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
            }
            try session.setActive(false)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override init() {
        super.init()
        
        // Initialize audio recorder
        let fileName:String = "User.wav"
        let path:String = NSHomeDirectory() + "/Documents/\(fileName)"
        let url:URL = URL(fileURLWithPath: path)
        let recordSettings:[String:Any] = [
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
            audioRecorder?.delegate = self
        } catch {
            print(error.localizedDescription)
        }
    }
}
