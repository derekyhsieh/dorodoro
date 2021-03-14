//
//  PlaySound.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/13/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            print("play sounds")
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("could not play or find sound file")
        }
    }
}
