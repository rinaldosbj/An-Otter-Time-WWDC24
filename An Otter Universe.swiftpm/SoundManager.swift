//
//  SoundManager.swift
//  An Otter Universe
//
//  Created by rsbj on 29/01/24.
//

import AVFoundation

class SoundManager {
    private var audioPlayer: AVAudioPlayer!
    static var shared = SoundManager()

    func playTheme() {
        let urlString = Bundle.main.url(forResource: "classical-1", withExtension: "mp3")
        
        guard urlString != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlString!)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
        catch {
            print ("\(error)")
        }
    }
    
    func pauseMusic() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
        else {
            audioPlayer.play()
        }
    }
}

