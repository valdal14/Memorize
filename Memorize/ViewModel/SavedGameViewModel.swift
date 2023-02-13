//
//  SavedGameViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 13/2/23.
//

import Foundation

class SavedGameViewModel: ObservableObject {
	@Published private(set) var inGameCard: [Card] = []
	@Published private(set) var savedGuessedCard: [Card] = []
	@Published private(set) var uncheckedSavedinGameCard: [Card] = []
	
	func retrivePlayerGame(playerSavedGames: [Game]) {
		for games in playerSavedGames {
			if let gameState = games.currentState {
				inGameCard = gameState
			}
			
			if let guessed = games.guessedCard {
				savedGuessedCard = guessed
			}
			
			if let unchecked = games.cards {
				uncheckedSavedinGameCard = unchecked
			}
		}
	}
}
