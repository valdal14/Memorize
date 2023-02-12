//
//  GameViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import Foundation

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
	
	init(deckGenerator: DeckGeneratorService) {
		self.deckGenerator = deckGenerator
		presentDifficultyLevel()
	}
	
	func shuffleDeck(selectedType: CardType, difficultyLevel: GameLevel) {
		inGameDeck = deckGenerator.shuffleDeckGenerator(selectedType: selectedType, difficultyLevel: difficultyLevel)
		for card in inGameDeck {
			originalCards.append(Card(isFaceUP: false, cardName: card))
		}
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
	
	func saveCurrentGame(player: Player, cardType: CardType, level: GameLevel) throws {
		for card in cards {
			originalCards[card.index] = Card(isFaceUP: card.isFaceUp, cardName: card.cardName)
		}
		
		for card in guessedCard {
			originalCards[card.index] = Card(isFaceUP: card.isFaceUp, cardName: card.cardName)
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
		newGame.currentState = originalCards
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
}

extension Array {
	subscript (safe index: Int) -> Element? {
		return (0 ..< count).contains(index) ? self[index] : nil
	}
}
