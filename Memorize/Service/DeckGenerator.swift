//
//  DeckGenerator.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation

protocol DeckGeneratorService {
	/// Based on the self selectedEmoji and selectedLevel
	/// returns an array of shuffled string equals to the size
	/// of difficulty level
	///
	/// - parameters: selectedType: CardType, difficultyLevel: GameLevel
	/// - returns: A new keyed encoding container.
	func shuffleDeckGenerator(selectedType: CardType, difficultyLevel: GameLevel) -> [String]
}

public class DeckGenerator: DeckGeneratorService {
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
