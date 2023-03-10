//
//  Memorize.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 7/2/23.
//

import SwiftUI

struct Memorize: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	
	@State private var columns : [GridItem] = [GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center)]
	@State private var showError = false
	@Binding var cardType: CardType
	@Binding var level: GameLevel
	@Binding var player: Player?
	@State private var goBack: Bool = false
	@Binding var wasNewGameComingFromALoadingGame: Bool
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .center, spacing: 4, content: {
			/// play game with downloaded images
			if gameVM.gameWithDownloadedImages {
				ForEach(0..<(level.rawValue * 2), id: \.self) { index in
					GameCard(cardName: gameVM.dowloadedCardName[index],
							 cardType: $cardType,
							 level: $level,
							 index: Binding<Int>(get: { index }, set: { _ in }))
				}
			} else {
				/// check if the game was loaded from core data
				if gameVM.wasGameLoaded {
					ForEach(gameVM.newGameFromLoadingState, id: \.index){ gameCard in
						gameCard
					}
				} else {
					ForEach(0..<(level.rawValue * 2), id: \.self) { index in
						GameCard(cardName: gameVM.inGameDeck[index],
								 cardType: $cardType,
								 level: $level,
								 index: Binding<Int>(get: { index }, set: { _ in }))
					}
				}
			}
		})
		VStack {
			if gameVM.isGameEnded {
				Text("Number of guesses: \(gameVM.guessCounter)")
					.fontWidth(.compressed)
					.font(.title)
				HStack(spacing: 20) {
					if gameVM.isCurrentFromDownloadedImages {
						Button("Main Menu") {
							// start the background track
							try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
							// go back
							goBack = true
						}
						.buttonStyle(.borderedProminent)
					} else {
						if wasNewGameComingFromALoadingGame {
							Button("Main Menu") {
								// restart the game if we go back
								gameVM.restartGame(selectedType: cardType, difficultyLevel: level)
								// start the background track
								try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
								// go back
								goBack = true
							}
							.buttonStyle(.borderedProminent)
						} else {
							Button("Play again") {
								// restart the game
								gameVM.restartGame(selectedType: cardType, difficultyLevel: level)
							}
							.buttonStyle(.borderedProminent)
							Button("Main menu") {
								// restart the game if we go back
								gameVM.restartGame(selectedType: cardType, difficultyLevel: level)
								// start the background track
								try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
								// go back
								goBack = true
							}
							.buttonStyle(.borderedProminent)
						}
					}
				}
			} else {
				ZStack {
					Circle()
						.fill(wasNewGameComingFromALoadingGame || gameVM.cards.count != 0 || gameVM.isCurrentFromDownloadedImages ? Color.red : Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.opacity(wasNewGameComingFromALoadingGame || gameVM.cards.count != 0 || gameVM.isCurrentFromDownloadedImages ? 0.5 : 1.0)
					Image(systemName: "bookmark.fill")
						.font(.system(size: 25))
						.foregroundColor(Color.white)
						.onTapGesture {
							/// save the current game
							if let player = self.player {
								do {
									try gameVM.saveCurrentGame(player: player, cardType: cardType, level: level)
									
									if gameVM.wasGameSaved {
										goBack = true
										try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
									}
								} catch {
									showError.toggle()
								}
							} else {
								showError.toggle()
							}
						}
						.disabled(wasNewGameComingFromALoadingGame || gameVM.cards.count != 0 || gameVM.isCurrentFromDownloadedImages)
				}
			}
		}
		.fullScreenCover(isPresented: $goBack, content: {
			UserSelectionView(resetStateAfterSave: $goBack)
		})
		.presentErrorWith(state:$showError, message: MemorizeError.invalidPlayer.rawValue)
		.padding()
		.edgesIgnoringSafeArea(.all)
	}
}

struct Momorize_Previews: PreviewProvider {
	@State static var cardType: CardType = CardType.emoji(.animal)
	@State static var level: GameLevel = .easy
	@State static var player: Player?
	@State static var newGameFromSave: Bool = false
	static var previews: some View {
		Memorize(cardType: $cardType, level: $level, player: $player, wasNewGameComingFromALoadingGame: $newGameFromSave)
	}
}
