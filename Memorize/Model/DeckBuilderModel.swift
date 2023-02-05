//
//  DeckBuilderModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 31/1/23.
//

struct EmojiStorage {
	static let animalDeck: [String] = ["🐸", "🦁", "🐼", "🦄", "🐷", "🐭", "🐨", "🦊", "🐮", "🐿", "🐰", "😺"]
	static let travelDeck: [String] = ["✈️", "🚗", "🚎", "🛳", "🚁", "🚂", "🏍", "🚲", "🗼", "🚖", "🚡", "🛻"]
}

enum GameLevel: Int {
	case easy = 6
	case medium = 9
	case hard = 12
}

enum CardType {
	case emoji(CardOption)
	case symbol(CardOption)
	case picture(CardOption)
	
	var symbols: [String] {
		switch self {
		case .emoji(let card):
			switch card {
			case .animal:
				return CardOption.animal.symbols
			case .travel:
				return CardOption.travel.symbols
			}
			
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
			return EmojiStorage.animalDeck
		case .travel:
			return EmojiStorage.travelDeck
		}
	}
}





