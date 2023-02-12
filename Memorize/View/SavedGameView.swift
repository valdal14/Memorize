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
	@Binding var player: Player?
	@State private var cardType: CardType = .emoji(.animal)
	@State private var level: GameLevel = .easy
	@State private var currentGameState: [Card] = []
	@State private var showGame = false
	
	
	var body: some View {
		ZStack {
			VStack {
				NavigationView {
					List {
						ForEach(onboardingVM.playerSavedgames) { games in
							ScrollView(.vertical, showsIndicators: true) {
								switch games.cardType {
								case "Memorize.EmojiOption.animal":
									Section {
										HStack {
											Text("Emoji Game")
												.foregroundColor(.accentColor)
												.padding(.bottom, 4)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.EmojiOption.sport":
									Section {
										HStack {
											Text("Emoji Game")
												.foregroundColor(.accentColor)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.EmojiOption.travel":
									Section {
										HStack {
											Text("Emoji Game")
												.foregroundColor(.accentColor)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.SymbolOption.device":
									Section {
										HStack {
											Text("Symbol Game")
												.foregroundColor(.accentColor)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.SymbolOption.gaming":
									Section {
										HStack {
											Text("Symbol Game")
												.foregroundColor(.accentColor)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.SymbolOption.nature":
									Section {
										HStack {
											Text("Symbol Game")
												.foregroundColor(.accentColor)
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
										if let level = GameLevel(rawValue: Int(games.level)) {
											self.level = level
											if let game = games.currentState {
												currentGameState = game
												showGame = true
											}
										}
									}
								case "Memorize.PictureOption.image":
									Text("toDO")
										.onTapGesture {
											cardType = .picture(.image)
											if let level = GameLevel(rawValue: Int(games.level)) {
												self.level = level
												if let game = games.currentState {
													currentGameState = game
													showGame = true
												}
											}
										}
								default:
									Text("OPPS!!!")
								}
							}
						}
					}
				}
				
				ZStack {
					Circle()
						.fill(Color.red)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
					Image(systemName: "xmark")
						.font(.system(size: 25))
						.foregroundColor(Color.white)
						.onTapGesture {
							dismiss()
						}
				}
			}
			.padding(30)
		}
		.background(Color("Background"))
		.edgesIgnoringSafeArea(.all)
		.fullScreenCover(isPresented: $showGame) {
			Memorize(cardType: $cardType, level: $level, player: $player)
		}
	}
}

struct SavedGameView_Previews: PreviewProvider {
	@State static var player: Player?
	static var previews: some View {
		SavedGameView(player: $player)
	}
}
