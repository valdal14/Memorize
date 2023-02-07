//
//  DeckViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation

class DeckViewModel: ObservableObject {
	private let deckGenerator: DeckGeneratorService
	
	@Published private(set) var difficulties: [Int] = []
	@Published private(set) var deckOptions: [String] = []
	
	init(deckGenerator: DeckGeneratorService) {
		self.deckGenerator = deckGenerator
		presentDifficultyLevel()
	}
	
	func shuffleDeck(selectedType: CardType, difficultyLevel: GameLevel) -> [String] {
		return deckGenerator.shuffleDeckGenerator(selectedType: selectedType, difficultyLevel: difficultyLevel)
	}
	
	func presentDifficultyLevel() {
		for level in GameLevel.allCases {
			difficulties.append(level.rawValue)
		}
	}
	
	func presentDeckOption(cardType: String) {
		switch cardType {
		case "Emoji":
			deckOptions = EmojiStorage.selectCardOption()
		case "Symbol":
			deckOptions = SymbolStorage.selectCardOption()
		case "Image":
			/// make the API call
			break
		default:
			break
		}
	}
}
