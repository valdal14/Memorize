//
//  UserSelectionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import SwiftUI

struct UserSelectionView: View {
	@State private var username: String = ""
	@State private var isTextFieldDisabled = false
	@State private var isSaveButtonDisable = true
	@State private var isNewGameDisabled = true
	@FocusState private var isFocused: Bool
	@StateObject var onboardingVM = OnboardingViewModel()
	@State private var player: Player?
	@State private var showError = false
	@State private var selectedName: String = ""
	@State private var showNext = false
	
	var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				if let player = player?.username, let wasLoaded = !player.isEmpty {
					if wasLoaded {
						Text("Welcome \(player)")
							.font(.headline)
							.foregroundColor(.accentColor)
					}
				} else {
					HStack {
						TextField(text: $username, label: {
							Text("enter your name")
						})
						.disabled(isTextFieldDisabled)
						.onChange(of: username, perform: { newPlayer in
							if newPlayer.count > 3 {
								isSaveButtonDisable = false
								selectedName = newPlayer
							} else {
								isSaveButtonDisable = true
							}
						})
						.foregroundColor(.accentColor)
						.focused($isFocused)
						.padding()
						
						Button {
							/// save the selected player
							onboardingVM.validateUsername(username: selectedName)
							/// get the last player name
							loadPlayer()
							DispatchQueue.main.async {
								if let _ = onboardingVM.chosenPlayerName {
									isTextFieldDisabled = false
									isSaveButtonDisable = false
								} else {
									showError = true
								}
							}
							
						} label: {
							Text("save")
						}
						.disabled(isSaveButtonDisable)
						.buttonStyle(.borderedProminent)
						.cornerRadius(15)
						.buttonStyle(.borderedProminent)
						.tint(.accentColor)
						
					}
					.padding()
				}
				Button {
					/// Start a new game
					showNext = true
				} label: {
					Text("Start New Game")
				}
				.disabled(isNewGameDisabled)
				.cornerRadius(15)
				.buttonStyle(.borderedProminent)
				.tint(.accentColor)
				Spacer()
				
			}
			.onAppear {
				/// get the last player name
				loadPlayer()
			}
			.padding(30)
		}
		.alert(isPresented: $onboardingVM.wasErrorRegistered, content: {
			Alert(title: Text("Memorize"),
				  message: Text("\(OnboardingError.errorGettingLastPlayer.rawValue)"),
				  dismissButton: .default(Text("Okay")))
		})
		.edgesIgnoringSafeArea(.all)
	}
	
	//MARK: - Helper function
	
	private func loadPlayer() {
		let lastPlayer = onboardingVM.getLastUser()
		if let lastPlayer {
			player = lastPlayer
			DispatchQueue.main.async {
				isTextFieldDisabled = true
				isNewGameDisabled = false
			}
		} else {
			DispatchQueue.main.async {
				isTextFieldDisabled = false
				isFocused = true
			}
		}
	}
}

struct UserSelectionView_Previews: PreviewProvider {
	static var previews: some View {
		UserSelectionView()
	}
}
