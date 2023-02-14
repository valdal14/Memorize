//
//  GameOptionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct GameOptionView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	
	@State private var presentCardSelection = false
	@State private var cardTypeString = ""
	@State private var selectedCardType: CardType?
	@Binding var level: GameLevel
	@Binding var player: Player?
	
    var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				/// Select the Card
				Text("Select Deck Theme")
					.font(.title)
					.foregroundColor(.accentColor)
					.padding(.bottom, 5)
				Text("emoji - symbol - images")
					.kerning(3)
					.fontWeight(.ultraLight)
					.font(.callout)
					.foregroundColor(.accentColor)
				HStack(spacing: 30) {
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Text("🐶")
								.font(.title2)
						}
						.onTapGesture {
							cardTypeString = "Emoji"
							presentCardSelection.toggle()
						}
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Image(systemName: "gamecontroller.fill")
								.foregroundColor(.white)
								.font(.title2)
						}
						.onTapGesture {
							cardTypeString = "Symbol"
							presentCardSelection.toggle()
						}
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Image("images")
								.resizable()
								.scaledToFit()
								.frame(width: 45, height: 45)
								.foregroundColor(.white)
								.font(.title2)
						}
						.onTapGesture {
							cardTypeString = "Image"
							presentCardSelection.toggle()
						}
				}
				.padding()
				
				Spacer()
				DismissView(dismiss: Binding<DismissAction>(
				get: { dismiss }, set: {_ in }))
			}
			.padding(30)
		}
		.edgesIgnoringSafeArea(.all)
		.sheet(isPresented: $presentCardSelection) {
			DeckPickerView(cardTypeString: $cardTypeString, level: $level, player: $player)
		}
    }
}

struct GameOptionView_Previews: PreviewProvider {
	@State static var level: GameLevel = .easy
	@State static var player: Player?
	
    static var previews: some View {
		GameOptionView(level: $level, player: $player)
    }
}
