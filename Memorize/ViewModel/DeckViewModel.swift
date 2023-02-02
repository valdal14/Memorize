//
//  DeckViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation

class DeckViewModel {
	private let deckGenerator: DeckGeneratorService
	
	init(deckGenerator: DeckGeneratorService) {
		self.deckGenerator = deckGenerator
	}
	
	func shuffleDeck(selectedType: CardType, difficultyLevel: GameLevel) -> [String] {
		return deckGenerator.shuffleDeckGenerator(selectedType: selectedType, difficultyLevel: difficultyLevel)
	}
}
