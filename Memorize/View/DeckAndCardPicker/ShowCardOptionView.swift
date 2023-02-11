//
//  ShowCardOptionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 11/2/23.
//

import SwiftUI

struct ShowCardOptionView: View {
	@EnvironmentObject var deckVM: DeckViewModel
	@EnvironmentObject var audioPlayer: AudioService
	@State private var startNewGame: Bool = false
	
	@Binding var cardTypeString: String
	@Binding var level: GameLevel
	
	@State private var card: CardType = CardType.emoji(.animal)
	
	var body: some View {
		ForEach(deckVM.deckOptions, id: \.self) { str in
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
						Text(cardTypeString)
					default:
						Text(str)
							.font(.title2)
					}
				}
				.onTapGesture {
					if let deckIndex = deckVM.deckOptions.firstIndex(of: str) {
						card = deckVM.createCardTypeFrom(cardName: cardTypeString, index: deckIndex)!
						playMemorize(cardType: card, level: level)
					}
				}
				/// present new screens
				.fullScreenCover(isPresented: $startNewGame, content: {
					Memorize(cardType: $card, level: $level)
				})
		}
	}
	
	//MARK: - Helper function
	func playMemorize(cardType: CardType, level: GameLevel) {
		audioPlayer.stopAudio()
		deckVM.shuffleDeck(selectedType: cardType, difficultyLevel: level)
		startNewGame.toggle()
	}
}

struct ShowCardOptionView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	@State static var level: GameLevel = .easy
	static var previews: some View {
		ShowCardOptionView(cardTypeString: $cardType, level: $level)
	}
}
