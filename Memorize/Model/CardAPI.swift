//
//  CardAPI.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import Foundation

struct CardAPI: Decodable, Sequence {
	let cards: [DownloadedCard]
	
	func makeIterator() -> some IteratorProtocol {
		return cards.makeIterator()
	}
	
	var underestimatedCount: Int {
		return cards.count
	}
	
	subscript(index: Int) -> DownloadedCard {
		return cards[index]
	}
}


struct DownloadedCard: Decodable {
	let image: String
}
