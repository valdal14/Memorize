//
//  GameViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
	
	private let deckGenerator: DeckGeneratorService
	
	@Published private(set) var difficulties: [Int] = []
	@Published var deckOptions: [String] = []
	@Published private(set) var inGameDeck: [String] = []
	
	@Published var cards : [GameCard] = []
	@Published var guessCounter : Int = 0
	@Published var isGameEnded : Bool = false
	@Published var guessedCard : [GameCard] = []
	@Published var originalCards: [Card] = []
	@Published var wasGameSaved: Bool = false
	@Published var wasGameLoaded: Bool = false
	@Published var newGameFromLoadingState: [GameCard] = []
	@Published var setIsFaceUPFromSavedCard: [Card] = []
	/// this is only if the player want to play with a deck of downloaded images
	@Published var dowloadedCardName: [String] = []
	@Published var dowloadedCard: [Image] = []
	@Published var gameWithDownloadedImages: Bool = false
	@Published var isCurrentFromDownloadedImages: Bool = false
	
	init(deckGenerator: DeckGeneratorService) {
		self.deckGenerator = deckGenerator
		presentDifficultyLevel()
	}
	
	func shuffleDeck(selectedType: CardType, difficultyLevel: GameLevel) {
		inGameDeck = deckGenerator.shuffleDeckGenerator(selectedType: selectedType, difficultyLevel: difficultyLevel)
		for (index, card) in inGameDeck.enumerated() {
			originalCards.append(Card(id: index, isFaceUP: false, cardName: card))
		}
		
		wasGameLoaded = false
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
			deckOptions = ["CircleLogo"]
			break
		default:
			break
		}
	}
	
	func createCardTypeFrom(cardName: String, index: Int) -> CardType? {
		var cardType: CardType?
		
		switch cardName {
		case "Emoji":
			switch index {
			case 0:
				cardType = CardType.emoji(.animal)
			case 1:
				cardType = CardType.emoji(.travel)
			case 2:
				cardType = CardType.emoji(.sport)
			default:
				cardType = CardType.emoji(.animal)
			}
		case "Symbol":
			switch index {
			case 0:
				cardType = CardType.symbol(.gaming)
			case 1:
				cardType = CardType.symbol(.nature)
			case 2:
				cardType = CardType.symbol(.device)
			default:
				cardType = CardType.symbol(.gaming)
			}
		case "Image":
			/// toDO
			break
		default:
			break
		}
		
		return cardType
	}
	
	func addCard(card: GameCard) {
		self.cards.append(card)
	}
	
	func endGame() {
		self.isGameEnded.toggle()
	}
	
	func restartGame(selectedType: CardType, difficultyLevel: GameLevel) {
		guessCounter = 0
		inGameDeck = []
		shuffleDeck(selectedType: selectedType, difficultyLevel: difficultyLevel)
		for index in 0..<guessedCard.count {
			let cardString = inGameDeck[index]
			guessedCard[index].isFaceUp = false
			guessedCard[index].cardType = selectedType
			guessedCard[index].cardName = cardString
		}
		guessedCard = []
		self.isGameEnded.toggle()
	}
	
	func resetAfterSave() {
		difficulties = []
		deckOptions = []
		inGameDeck = []
		cards = []
		guessCounter = 0
		isGameEnded = false
		guessedCard = []
		originalCards = []
		wasGameSaved = false
		wasGameLoaded = false
		newGameFromLoadingState = []
		setIsFaceUPFromSavedCard = []
	}
	
	func saveCurrentGame(player: Player, cardType: CardType, level: GameLevel) throws {
		var uncheckedToBeSaved: [Card] = []
		var guessedToBeSaved: [Card] = []
		
		for card in cards {
			originalCards[card.index] = Card(id: card.index, isFaceUP: card.isFaceUp, cardName: card.cardName)
			uncheckedToBeSaved.append(Card(id: card.index, isFaceUP: card.isFaceUp, cardName: card.cardName))
		}
		
		for card in guessedCard {
			originalCards[card.index] = Card(id: card.index, isFaceUP: card.isFaceUp, cardName: card.cardName)
			guessedToBeSaved.append(Card(id: card.index, isFaceUP: card.isFaceUp, cardName: card.cardName))
		}
		
		let level = level.rawValue
		var cardStringType: String?
		
		switch cardType {
		case .emoji(.animal):
			cardStringType = "Memorize.EmojiOption.animal"
		case .emoji(.sport):
			cardStringType = "Memorize.EmojiOption.sport"
		case .emoji(.travel):
			cardStringType = "Memorize.EmojiOption.travel"
		case .symbol(.device):
			cardStringType = "Memorize.SymbolOption.device"
		case .symbol(.gaming):
			cardStringType = "Memorize.SymbolOption.gaming"
		case .symbol(.nature):
			cardStringType = "Memorize.SymbolOption.nature"
		case .picture(.image):
			cardStringType = "Memorize.PictureOption.image"
		}
		
		/// create a new game object
		let newGame = Game(context: PersistenceController.shared.container.viewContext)
		newGame.guesses = Int64(guessCounter)
		newGame.currentState = originalCards
		newGame.cards = uncheckedToBeSaved
		newGame.guessedCard = guessedToBeSaved
		newGame.level = Int64(level)
		if let cardStringType = cardStringType {
			newGame.cardType = cardStringType
		}
		player.addToGames(newGame)
		
		do {
			try PersistenceController.shared.container.viewContext.save()
			wasGameSaved = true
		} catch {
			throw MemorizeError.coreDataError
		}
	}
	
	func fillInGameDeck(currentGameState: [Card], guessed: [Card], unChecked: [Card], cardType: CardType, level: GameLevel, guesses: Int){
		
		guessCounter = guesses
		
		for card in currentGameState {
			inGameDeck.append(card.cardName)
		}
		
		for card in guessed {
			let savedCard = GameCard(cardName: card.cardName,
									 cardType: Binding<CardType>(get: { cardType }, set: { _ in }),
									 level: Binding<GameLevel>(get: { level }, set: { _ in }),
									 index: Binding<Int>(get: { card.id }, set: {_ in }))
			
			guessedCard.append(savedCard)
		}
		
		for card in unChecked {
			let savedCard = GameCard(cardName: card.cardName,
									 cardType: Binding<CardType>(get: { cardType }, set: { _ in }),
									 level: Binding<GameLevel>(get: { level }, set: { _ in }),
									 index: Binding<Int>(get: { card.id }, set: {_ in }))
			
			cards.append(savedCard)
		}
		
		restoreGame(currentGameState: currentGameState, carsdType: cardType, level: level)
		
		/// used to switch the state
		for card in currentGameState {
			setIsFaceUPFromSavedCard.append(card)
		}
		
		wasGameLoaded = true
	}
	
	private func restoreGame(currentGameState: [Card], carsdType: CardType, level: GameLevel) {
		for card in currentGameState {
			let savedCard = GameCard(cardName: card.cardName,
									 cardType: Binding<CardType>(get: { carsdType }, set: { _ in }),
									 level: Binding<GameLevel>(get: { level }, set: { _ in }),
									 index: Binding<Int>(get: { card.id }, set: {_ in }))
			
			newGameFromLoadingState.append(savedCard)
		}
	}

	func setGameCardIsFaceUp(currentGameState: [Card], index: Int, isFaceUp: Binding<Bool>){
		return isFaceUp.wrappedValue = currentGameState[index].isFaceUP
	}
	
	func setupDeckFromImages(dowloadedImage: Image, imageName: String) {
		dowloadedCard.append(dowloadedImage)
		dowloadedCardName.append(imageName)
	}
	
	func shuffleImageDeck(){
		dowloadedCard.shuffled()
	}
}

extension Array {
	subscript (safe index: Int) -> Element? {
		return (0 ..< count).contains(index) ? self[index] : nil
	}
}
