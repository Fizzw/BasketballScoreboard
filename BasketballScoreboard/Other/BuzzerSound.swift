//
//  BuzzerSound.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import AVFoundation

class BuzzerSound {
    var player: AVAudioPlayer?

    func play() {
        if let url = Bundle.main.url(forResource: "buzzer", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Buzzer sound error: \(error.localizedDescription)")
            }
        }
    }
}
