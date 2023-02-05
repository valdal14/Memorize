//
//  Card.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import Foundation

public class Card: ValueTransformer, NSCoding, Identifiable {
	public let id = UUID().uuidString
	public let isFaceUP: Bool
	public let cardName: String
	
	init(isFaceUP: Bool, cardName: String) {
		self.isFaceUP = isFaceUP
		self.cardName = cardName
	}
	
	public required init?(coder: NSCoder) {
		isFaceUP = coder.decodeBool(forKey: "isFaceUP")
		cardName = coder.decodeObject(forKey: "cardName") as? String ?? ""
	}
	
	public func encode(with coder: NSCoder) {
		coder.encode(isFaceUP, forKey: "isFaceUP")
		coder.encode(cardName, forKey: "cardName")
	}
}
