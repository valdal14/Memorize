//
//  SavedGameViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 13/2/23.
//

import Foundation

class SavedGameViewModel: ObservableObject {
	@Published private(set) var inGameCard: [[Card]] = []
	@Published private(set) var savedGuessedCard: [[Card]] = []
	@Published private(set) var uncheckedSavedinGameCard: [[Card]] = []
	@Published private(set) var gameLevels: [Int64] = []
	
	func retrivePlayerGame(playerSavedGames: [Game]) {
		
		inGameCard = Array(repeating: [Card](), count: playerSavedGames.count)
		savedGuessedCard = Array(repeating: [Card](), count: playerSavedGames.count)
		uncheckedSavedinGameCard = Array(repeating: [Card](), count: playerSavedGames.count)
		
		for (index, game) in playerSavedGames.enumerated() {
			
			// store the current level game
			gameLevels.append(game.level)
			
			if let games = game.currentState {
				for gameCard in games {
					inGameCard[index].append(gameCard)
				}
			}
			
			if let guessed = game.guessedCard {
				for gameCard in guessed {
					savedGuessedCard[index].append(gameCard)
				}
			}
			
			if let unchecked = game.cards {
				for gameCard in unchecked {
					uncheckedSavedinGameCard[index].append(gameCard)
				}
			}

		}
	}
	
	func getCardFromCurrentSelectedSavedGame(currentGame: [Card]) -> ([Card], [Card], [Card], Int64) {
		var selectedDeckIndex: Int = 0
		var selectedDeck: [Card] = []
		var uncheckCard: [Card] = []
		var guessedCard: [Card] = []
		
		for (index, card) in inGameCard.enumerated() {
			if currentGame == card {
				selectedDeck = card
				selectedDeckIndex = index
				break
			}
		}
		
		uncheckCard = uncheckedSavedinGameCard[selectedDeckIndex]
		guessedCard = savedGuessedCard[selectedDeckIndex]
		let selectedGameLevel: Int64 = gameLevels[selectedDeckIndex]
		
		return (selectedDeck, guessedCard, uncheckCard, selectedGameLevel)
	}
}
