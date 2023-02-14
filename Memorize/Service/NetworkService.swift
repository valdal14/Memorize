//
//  NetworkService.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import Foundation

protocol NetworkServicing {
	func drawCard(numberOfCards: Int) async throws -> [String]
}

class NetworkService: NetworkServicing {
	
	enum Endpoint: String {
		case baseURL = "https://deckofcardsapi.com/api/deck/new/draw/?count="
		var url: URL { return URL(string: self.rawValue)! }
	}
	
	enum NetworkManagerError : Error {
		case badurl
		case badRequest
		case decodingError
	}
	
	func drawCard(numberOfCards: Int) async throws -> [String] {
		guard let url = URL(string: Endpoint.baseURL.rawValue + "\(numberOfCards)") else { throw NetworkManagerError.badurl }
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			let decodedData = try JSONDecoder().decode(CardAPI.self, from: data)
			print(decodedData.cards)
			return storeCard(cards: decodedData.cards)
		default:
			throw NetworkManagerError.badRequest
		}
	}
	
	//MARK: - Helper function
	func storeCard(cards: [DownloadedCard]) -> [String] {
		return cards.map { $0.image }
	}
}
