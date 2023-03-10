//
//  AudioService.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
	func playBackgroundMusic(fileName: String, fileExtension: String) throws
}

class AudioService: AudioPlayerService, ObservableObject {
	@Published private(set) var audioPlayer : AVAudioPlayer?
	
	func playBackgroundMusic(fileName: String, fileExtension: String) throws {
		if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
			audioPlayer?.volume = 0.5
			audioPlayer?.numberOfLoops = -1
			audioPlayer?.play()
		}
	}
	
	func playSound(fileName: String, fileExtension: String) throws {
		if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
			audioPlayer?.play()
		}
	}
	
	func stopAudio(){
		audioPlayer?.stop()
	}
}

