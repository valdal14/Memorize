//
//  OnboardingViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import CoreData
import Foundation

enum OnboardingError: String {
	case errorGettingLastPlayer = "Error: 101 - Cannot get user profile from internal storage"
	case errorSavingPlayer = "Error: 102 - Cannot save username"
	case duplicatedPlayerName = "Error: 103 - Player name already exists, please select a different player name"
}

class OnboardingViewModel: ObservableObject {
	@Published var chosenPlayerName: String?
	@Published var wasErrorRegistered: Bool = false
	
	func getLastUser() -> Player? {
		let request = NSFetchRequest<Player>(entityName: "Player") as NSFetchRequest<Player>
		let players = try? PersistenceController.shared.container.viewContext.fetch(request)
		let player = players?.last
		if let player {
			return player
		} else {
			return nil
		}
	}
	
	private func saveCurrentPlayer(username: String) {
		let newPlayer = Player(context: PersistenceController.shared.container.viewContext)
		newPlayer.username = username
		try? PersistenceController.shared.container.viewContext.save()
	}
	
	func validateUsername(username: String) {
		let request = NSFetchRequest<Player>(entityName: "Player") as NSFetchRequest<Player>
		let players = try? PersistenceController.shared.container.viewContext.fetch(request)
		if let players {
			for player in players {
				if player.username == username {
					wasErrorRegistered = true
				}
			}
			saveCurrentPlayer(username: username)
			chosenPlayerName = username
		} else {
			wasErrorRegistered = true
		}
	}
}
