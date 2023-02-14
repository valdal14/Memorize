//
//  SavedGameView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct SavedGameView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@StateObject var savedGamesVM = SavedGameViewModel()
	@Binding var player: Player?
	@State private var cardType: CardType = .emoji(.animal)
	@State private var level: GameLevel = .easy
	@State private var currentGameState: [Card] = []
	@State private var showGame = false
	@State private var savedGame = true
	@State private var numberOfGuesses: Int = 0
	let maxLength = 10
	
	var body: some View {
		ZStack {
			VStack {
				List {
					ForEach(onboardingVM.playerSavedgames) { games in
						ScrollView(.vertical, showsIndicators: true) {
							switch games.cardType {
							case "Memorize.EmojiOption.animal":
								Section {
									HStack {
										Text("Emoji Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
											.foregroundColor(.accentColor)
										Text("🦊")
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Text(card.isFaceUP ? card.cardName : "?")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .emoji(.animal)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							case "Memorize.EmojiOption.sport":
								Section {
									HStack {
										Text("Emoji Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
											.foregroundColor(.accentColor)
										Text("🎲")
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Text(card.isFaceUP ? card.cardName : "?")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .emoji(.sport)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							case "Memorize.EmojiOption.travel":
								Section {
									HStack {
										Text("Emoji Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
											.foregroundColor(.accentColor)
										Text("✈️")
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Text(card.isFaceUP ? card.cardName : "?")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .emoji(.travel)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							case "Memorize.SymbolOption.device":
								Section {
									HStack {
										Text("Symbol Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
										Image(systemName: "applewatch.watchface")
											.foregroundColor(.accentColor)
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Image(systemName: card.isFaceUP ? card.cardName : "questionmark.circle.fill")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .symbol(.device)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							case "Memorize.SymbolOption.gaming":
								Section {
									HStack {
										Text("Symbol Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
										Image(systemName: "xbox.logo")
											.foregroundColor(.accentColor)
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Image(systemName: card.isFaceUP ? card.cardName : "questionmark.circle.fill")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .symbol(.gaming)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							case "Memorize.SymbolOption.nature":
								Section {
									HStack {
										Text("Symbol Game")
											.foregroundColor(.accentColor)
											.padding(.bottom, 5)
										Spacer()
										Image(systemName: "tree.fill")
											.foregroundColor(.accentColor)
									}
								}
								HStack {
									ForEach(games.currentState!) { card in
										Image(systemName: card.isFaceUP ? card.cardName : "questionmark.circle.fill")
									}
									Spacer()
								}
								.onTapGesture {
									cardType = .symbol(.nature)
									prepareSavedGameToPlay(game: games.currentState ?? [],
														   cardType: cardType,
														   guesses: Int(games.guesses))
								}
							default:
								Text("")
							}
						}
					}
				}
				Spacer()
				DismissView(dismiss: Binding<DismissAction>(
					get: { dismiss }, set: {_ in }))
				.padding(30)
			}
		}
		.onAppear {
			savedGamesVM.retrivePlayerGame(playerSavedGames: onboardingVM.playerSavedgames)
		}
		.edgesIgnoringSafeArea(.all)
		.fullScreenCover(isPresented: $showGame) {
			Memorize(cardType: $cardType, level: $level, player: $player, wasNewGameComingFromALoadingGame: $savedGame)
		}
	}
	
	//MARK: - Helper function
	func prepareSavedGameToPlay(game: [Card]?, cardType: CardType, guesses: Int) {
		if let currentGame = game {
			let (gameOne, guessedOne, uncheckedOne, selectedLevel) = savedGamesVM.getCardFromCurrentSelectedSavedGame(currentGame: currentGame)
			/// pass the level we retrieved
			self.level = GameLevel(rawValue: Int(selectedLevel)) ?? .easy
			
			gameVM.fillInGameDeck(currentGameState: gameOne,
								  guessed: guessedOne,
								  unChecked: uncheckedOne,
								  cardType: cardType,
								  level: self.level,
								  guesses: Int(guesses))
			showGame = true
		}
	}
	
}

struct SavedGameView_Previews: PreviewProvider {
	@State static var player: Player?
	static var previews: some View {
		SavedGameView(player: $player)
	}
}
