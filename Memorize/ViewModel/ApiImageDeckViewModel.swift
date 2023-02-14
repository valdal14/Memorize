//
//  ApiImageDeckViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import Foundation

class ApiImageDeckViewModel: ObservableObject {
	
	private let deckGenerator: DeckGeneratorService
	
	@Published var newAPIDeck: [String] = []
	@Published var cardType: CardType = .picture(.image)
	@Published var level: GameLevel = .easy
	@Published var player: Player?
	@Published var wasGameLoaded: Bool = false
	
	init(newAPIDeck: [String], cardType: CardType, level: GameLevel, player: Player, deckGenerator: DeckGeneratorService = DeckGenerator()) {
		self.newAPIDeck = newAPIDeck
		self.cardType = cardType
		self.level = level
		self.player = player
		self.deckGenerator = deckGenerator
	}
}
