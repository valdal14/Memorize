//
//  UserSelectionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import SwiftUI

struct UserSelectionView: View {
	@EnvironmentObject var audioPlayer: AudioService
	@StateObject var gameVM = GameViewModel(deckGenerator: DeckGenerator())
	@FocusState private var isFocused: Bool
	@StateObject var onboardingVM = OnboardingViewModel()
	@StateObject var wrapper = UserSelectionPropertyWrapper()
	@Binding var resetStateAfterSave: Bool
	@State private var showCredits: Bool = false
	
	var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				if let player = wrapper.player?.username, let wasLoaded = !player.isEmpty {
					if wasLoaded {
						Text("Welcome \(player)")
							.font(.largeTitle)
							.fontWeight(.thin)
							.foregroundColor(.accentColor)
					}
				} else {
					/// New Player Section
					HStack {
						TextField(text: $wrapper.username, label: {
							Text("enter your name")
						})
						.disabled(wrapper.isTextFieldDisabled)
						.onChange(of: wrapper.username, perform: { newPlayer in
							if newPlayer.count > 3 {
								wrapper.isSaveButtonDisable = false
								wrapper.selectedName = newPlayer
							} else {
								wrapper.isSaveButtonDisable = true
							}
						})
						.foregroundColor(.accentColor)
						.focused($isFocused)
						.padding()
						
						Button {
							/// save the selected player
							onboardingVM.validateUsername(username: wrapper.selectedName)
							/// get the last player name
							loadPlayer()
							DispatchQueue.main.async {
								if let _ = onboardingVM.chosenPlayerName {
									wrapper.isTextFieldDisabled = false
									wrapper.isSaveButtonDisable = false
								} else {
									wrapper.showError = true
								}
							}
							
						} label: {
							Text("save")
						}
						.disabled(wrapper.isSaveButtonDisable)
						.buttonStyle(.borderedProminent)
						.cornerRadius(15)
						.tint(.accentColor)
						
					}
					.padding()
					/// End of New Player Section
				}
				/// New Game Button
				Button {
					wrapper.presentGameOptionView.toggle()
				} label: {
					Text(" New Game ")
				}
				.disabled( wrapper.isNewGameDisabled)
				.cornerRadius(15)
				.buttonStyle(.borderedProminent)
				.tint(.accentColor)
				.controlSize(.large)
				/// Check if current player has saved games
				if !onboardingVM.playerSavedgames.isEmpty {
					Button {
						/// show saved games
						wrapper.presentSavedGamesView.toggle()
					} label: {
						Text("Load Games")
					}
					.buttonStyle(.borderedProminent)
					.cornerRadius(15)
					.tint(.accentColor)
					.controlSize(.large)
					.padding()

				}
				Spacer()
				ZStack {
					Circle()
						.fill(Color.accentColor)
						.frame(width: 50, height: 50)
						.shadow(radius: 10)
					Image(systemName: "gear")
						.font(.system(size: 20))
						.foregroundColor(Color.white)
						.onTapGesture {
							showCredits.toggle()
						}
				}
			}
			.onAppear {
				/// get the last player name
				loadPlayer()
			}
			.padding(30)
		}
		.presentErrorWith(state: $wrapper.showError, message: MemorizeError.coreDataError.rawValue)
		.edgesIgnoringSafeArea(.all)
		/// present new screens
		.fullScreenCover(isPresented: $wrapper.presentGameOptionView, content: {
			LevelOptionView(player: $wrapper.player)
		})
		.fullScreenCover(isPresented: $wrapper.presentSavedGamesView, content: {
			SavedGameView(player: $wrapper.player)
		})
		.environmentObject(onboardingVM)
		.environmentObject(gameVM)
		.onChange(of: resetStateAfterSave) { _ in
			gameVM.resetAfterSave()
		}
		.sheet(isPresented: $showCredits) {
			GameCreditsView()
		}
	}
	
	//MARK: - Helper function
	
	private func loadPlayer() {
		let lastPlayer = onboardingVM.getLastUser()
		if let lastPlayer {
			wrapper.player = lastPlayer
			DispatchQueue.main.async {
				wrapper.isTextFieldDisabled = true
				wrapper.isNewGameDisabled = false
			}
		} else {
			DispatchQueue.main.async {
				wrapper.isTextFieldDisabled = false
				isFocused = true
			}
		}
	}
}

struct UserSelectionView_Previews: PreviewProvider {
	@State static var reset: Bool = false
	static var previews: some View {
		UserSelectionView(resetStateAfterSave: $reset)
	}
}
