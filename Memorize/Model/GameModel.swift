//
//  GameModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 31/1/23.
//

import SwiftUI

enum GameLevel: Int {
	case easy = 6
	case medium = 9
	case hard = 12
}

enum CardType: String {
	case emoji
	case symbol
	case picture
	
	var symbols: [String] {
		switch self {
		case .emoji:
			return CardOption.animal.symbols
		case .symbol:
			return [""]
		case .picture:
			return [""]
		}
	}
}

enum CardOption: String {
	case animal = "🦁"
	case travel = "✈️"
	
	var symbols: [String] {
		switch self {
		case .animal:
			return ["🐸", "🦁", "🐼", "🦄", "🐷", "🐭"]
		case .travel:
			return ["✈️", "🚗", "🚎", "🛳", "🚁", "🚂"]
		}
	}
}

struct Card {
	private let listOfcard: [String]
	private let gameLevel: GameLevel
	
	var counter = 0
	var cards: [String] = []
	
	init(listOfcard: [String], gameLevel: GameLevel) {
		self.listOfcard = listOfcard
		self.gameLevel = gameLevel
		
		/// init the listOfcard
		var picArray : [String] = []
		while counter != gameLevel.rawValue {
			let index = Int.random(in: 0..<gameLevel.rawValue)
			if !picArray.contains(listOfcard[index]) {
				picArray.append(listOfcard[index])
				counter += 1
			}
		}
		
		let sorted = picArray.sorted()
		self.cards = sorted + picArray
		self.cards.shuffle()
	}
}





