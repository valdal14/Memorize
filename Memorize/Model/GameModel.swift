//
//  GameModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 31/1/23.
//

protocol DeckGeneratorService {
	/// Based on the self selectedEmoji and selectedLevel
	/// returns an array of shuffled string equals to the size
	/// of difficulty level
	///
	/// - parameters: selectedType: CardType, difficultyLevel: GameLevel
	/// - returns: A new keyed encoding container.
	func shuffleDeckGenerator(selectedType: CardType, difficultyLevel: GameLevel) -> [String]
}

class DeckGenerator: DeckGeneratorService {
	func shuffleDeckGenerator(selectedType: CardType, difficultyLevel: GameLevel) -> [String] {
		var deck: [String] = []
		var shuffleDeck: [String] = []
		
		switch selectedType {
		case .emoji:
			shuffleDeck = selectedType.symbols.shuffled()
		case .symbol:
			shuffleDeck = selectedType.symbols.shuffled()
		case .picture:
			shuffleDeck = selectedType.symbols.shuffled()
		}
		
		for cardAtIndex in 0..<difficultyLevel.rawValue {
			deck.append(shuffleDeck[cardAtIndex])
		}
		
		return deck
	}
}

class DeckViewModel {
	private let deckGenerator: DeckGeneratorService
	
	init(deckGenerator: DeckGeneratorService) {
		self.deckGenerator = deckGenerator
	}
	
	func shuffleDeck(selectedType: CardType, difficultyLevel: GameLevel) -> [String] {
		return deckGenerator.shuffleDeckGenerator(selectedType: selectedType, difficultyLevel: difficultyLevel)
	}
}

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





