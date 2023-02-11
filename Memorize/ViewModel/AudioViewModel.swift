//
//  AudioViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation

enum AudioPlayerError: String, Error {
	case audioError = "There was an error reproducing the sound"
}

class SoundPlayer {
	private let audioService: AudioService
	
	init(audioService: AudioService) {
		self.audioService = audioService
	}
	
	func playSound(fileName: String, fileExtension: String) throws {
		do {
			try audioService.playBackgroundMusic(fileName: fileName, fileExtension: fileExtension)
		} catch {
			throw AudioPlayerError.audioError
		}
	}
}
