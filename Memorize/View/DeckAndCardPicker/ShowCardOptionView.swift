//
//  ShowCardOptionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 11/2/23.
//

import SwiftUI

struct ShowCardOptionView: View {
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	@State private var startNewGame: Bool = false
	
	@Binding var cardTypeString: String
	@Binding var level: GameLevel
	
	@State private var card: CardType = CardType.emoji(.animal)
	@Binding var player: Player?
	@State private var presentImageGame: Bool = false
	@State private var apiCardStateView: APICardStateView?
	
	var body: some View {
		ForEach(gameVM.deckOptions, id: \.self) { str in
			Circle()
				.fill(Color.accentColor)
				.frame(width: 70, height: 70)
				.shadow(radius: 10)
				.overlay {
					switch cardTypeString {
					case "Emoji":
						Text(str)
							.font(.title2)
					case "Symbol":
						Image(systemName: "\(str)")
							.foregroundColor(.white)
							.font(.title2)
					case "Image":
						Image(str)
							.resizable()
							.scaledToFill()
					default:
						Text(str)
							.font(.title2)
					}
				}
				.onTapGesture {
					/// if the user selected Image start the download
					if cardTypeString == "Image" {
						if let player = player {
							apiCardStateView = APICardStateView(apiCardStateVM: APICardStateViewModel(numberOfCards: level.rawValue, cardType: CardType.picture(.image), level: level, player: player))
							presentImageGame = true
						}
					} else {
						if let deckIndex = gameVM.deckOptions.firstIndex(of: str) {
							card = gameVM.createCardTypeFrom(cardName: cardTypeString, index: deckIndex)!
							playMemorize(cardType: card, level: level)
						}
					}
				}
				/// present new screens
				.fullScreenCover(isPresented: $startNewGame, content: {
					Memorize(cardType: $card, level: $level, player: $player, wasNewGameComingFromALoadingGame: Binding(get: { false }, set: {_ in }))
				})
				.fullScreenCover(isPresented: $presentImageGame) {
					apiCardStateView
				}
		}
	}
	
	//MARK: - Helper function
	func playMemorize(cardType: CardType, level: GameLevel) {
		audioPlayer.stopAudio()
		gameVM.shuffleDeck(selectedType: cardType, difficultyLevel: level)
		startNewGame.toggle()
	}
}

struct ShowCardOptionView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	@State static var level: GameLevel = .easy
	@State static var player: Player?
	static var previews: some View {
		ShowCardOptionView(cardTypeString: $cardType, level: $level, player: $player)
	}
}
