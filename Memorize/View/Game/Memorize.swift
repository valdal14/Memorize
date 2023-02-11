//
//  Memorize.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 7/2/23.
//

import SwiftUI

struct Memorize: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var deckVM: DeckViewModel
	
	@State private var columns : [GridItem] = [GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center)]
	
	@Binding var cardType: CardType
	@Binding var level: GameLevel
	
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .center, spacing: 4, content: {
			ForEach(0..<(level.rawValue * 2), id: \.self) { index in
				GameCard(cardName: deckVM.inGameDeck[index], cardType: $cardType, level: $level)
			}
		})
		VStack {
			if deckVM.isGameEnded {
				Text("Number of guesses: \(deckVM.guessCounter)")
					.fontWidth(.compressed)
					.font(.title)
				HStack(spacing: 20) {
					Button("Play again") {
						// restart the game
						deckVM.restartGame(selectedType: cardType, difficultyLevel: level)
					}
					.buttonStyle(.borderedProminent)
					Button("Main menu") {
						// change game
					}
					.buttonStyle(.borderedProminent)
				}
			} else {
				ZStack {
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
					Image(systemName: "bookmark.fill")
						.font(.system(size: 25))
						.foregroundColor(Color.white)
						.onTapGesture {
							/// save the current game
						}
				}
			}
		}
		
		.padding()
		.edgesIgnoringSafeArea(.all)
	}
}

struct Momorize_Previews: PreviewProvider {
	@State static var cardType: CardType = CardType.emoji(.animal)
	@State static var level: GameLevel = .easy
	static var previews: some View {
		Memorize(cardType: $cardType, level: $level)
	}
}
