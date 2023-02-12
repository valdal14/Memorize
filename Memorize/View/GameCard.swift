//
//  GameCard.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 11/2/23.
//

import SwiftUI

struct GameCard: View {
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var deckVM: GameViewModel
	@State var cardName : String
	@State var isFaceUp : Bool = false
	@State var cardBackground = Color.accentColor
	@State var degree : Double = 0
	var cardW : CGFloat = 90.0
	var cardH : CGFloat = 110
	
	@Binding var cardType: CardType
	@Binding var level: GameLevel
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10.0, style: .continuous)
				.fill(cardBackground)
				.frame(width: cardW, height: cardH, alignment: .center)
				.overlay(
					RoundedRectangle(cornerRadius: 10.0, style: .continuous)
						.stroke()
						.frame(width: 80, height: 100)
						.foregroundColor(.white)
				)
			if isFaceUp {
				switch cardType {
				case .emoji(.animal), .emoji(.sport), .emoji(.travel):
					Text(cardName)
						.font(.largeTitle)
				case .symbol(.device), .symbol(.nature), .symbol(.gaming):
					Image(systemName: cardName)
						.font(.largeTitle)
						.foregroundColor(.white)
				case .picture(.image):
					// toDO
					Text("Image")
				}
			}
		}
		.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
		.onTapGesture {
			if !self.isFaceUp {
				withAnimation(.linear(duration: 0.3)) {
					degree = 90
				}
				withAnimation(.linear(duration: 0.6)) {
					degree = -90
				}
				isFaceUp.toggle()
				degree = 0
				
				deckVM.addCard(card: self)
				playGame()
			}
		}
    }
	
	//MARK: - Helper
	private func playGame() {
		if deckVM.cards.count == 2 {
			if deckVM.cards[0].cardName != deckVM.cards[1].cardName {
				withAnimation(.linear(duration: 0.3)) {
					degree -= 90
				}
				withAnimation(.linear(duration: 0.6)) {
					degree += 90
				}
				degree = 0
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, qos: .userInitiated) {
					deckVM.cards[0].isFaceUp = false
					deckVM.cards[1].isFaceUp = false
					deckVM.cards.remove(at: 0)
					deckVM.cards.remove(at: 0)
				}
			} else {
				deckVM.guessedCard.append(deckVM.cards[0])
				deckVM.guessedCard.append(deckVM.cards[1])
				deckVM.cards.remove(at: 0)
				deckVM.cards.remove(at: 0)
				try? audioPlayer.playSound(fileName: "chimeup", fileExtension: "mp3")
				
				/// end game
				if deckVM.guessedCard.count == (level.rawValue * 2) {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, qos: .userInitiated) {
						try? self.audioPlayer.playSound(fileName: "success", fileExtension: "m4a")
						deckVM.endGame()
					}
				}
			}
			deckVM.guessCounter += 1
		}
	}
}

struct GameCard_Previews: PreviewProvider {
	@State static var cardName : String = "😜"
	@State static var isFaceUp = true
	@State static var cardType: CardType = CardType.emoji(.animal)
	@State static var level: GameLevel = .easy
	
    static var previews: some View {
		GameCard(cardName: cardName, isFaceUp: isFaceUp, cardType: $cardType, level: $level)
    }
}
