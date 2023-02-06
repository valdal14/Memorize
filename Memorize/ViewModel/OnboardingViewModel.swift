//
//  OnboardingViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import CoreData
import Foundation

class OnboardingViewModel: ObservableObject {
	@Published var chosenPlayerName: String?
	@Published var wasErrorRegistered: Bool = false
	@Published var playerSavedgames: [Card] = []
	
	func getLastUser() -> Player? {
		let request = NSFetchRequest<Player>(entityName: "Player") as NSFetchRequest<Player>
		let players = try? PersistenceController.shared.container.viewContext.fetch(request)
		let player = players?.last
		if let player {
			let games = player.games?.allObjects as! [Card]
			playerSavedgames = games.reversed()
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
