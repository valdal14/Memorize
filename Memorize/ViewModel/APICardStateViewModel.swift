//
//  APICardStateViewModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import Foundation

@MainActor
class APICardStateViewModel: ObservableObject {
	private let networkService: NetworkService
	
	enum State<T> {
		case loading
		case success(T)
		case error(errorMessage: String)
	}
	
	@Published var cardType: CardType
	@Published var level: GameLevel
	@Published var player: Player
	
	init(networkService: NetworkService = NetworkService(), numberOfCards: Int, cardType: CardType, level: GameLevel, player: Player) {
		self.networkService = networkService
		self.cardType = cardType
		self.level = level
		self.player = player
		self.start(numberOfCards: numberOfCards)
	}
	
	@Published private(set) var state: State<ApiImageDeckViewModel> = .loading
	
	private func start(numberOfCards: Int) {
		Task {
			do {
				let model: [String] = try await self.networkService.drawCard(numberOfCards: numberOfCards)
				await MainActor.run(body: {
					self.state = .success(.init(newAPIDeck: model, cardType: cardType, level: level, player: player))
				})
			} catch let error as NetworkService.NetworkManagerError {
				switch error {
				case .badRequest:
					break
				case .badurl:
					break
				case .decodingError:
					break
				}
				
				await MainActor.run {
					self.state = .error(errorMessage: error.localizedDescription)
				}
			} catch {
				await MainActor.run {
					self.state = .error(errorMessage: error.localizedDescription)
				}
			}
		}
	}
}
