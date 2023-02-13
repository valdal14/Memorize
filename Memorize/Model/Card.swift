//
//  Card.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import Foundation

public class Card: ValueTransformer, NSCoding, Identifiable {
	public let id: Int
	public let isFaceUP: Bool
	public let cardName: String
	
	init(id: Int, isFaceUP: Bool, cardName: String) {
		self.id = id
		self.isFaceUP = isFaceUP
		self.cardName = cardName
	}
	
	public required init?(coder: NSCoder) {
		id = coder.decodeInteger(forKey: "id")
		isFaceUP = coder.decodeBool(forKey: "isFaceUP")
		cardName = coder.decodeObject(forKey: "cardName") as? String ?? ""
	}
	
	public func encode(with coder: NSCoder) {
		coder.encode(id, forKey: "id")
		coder.encode(isFaceUP, forKey: "isFaceUP")
		coder.encode(cardName, forKey: "cardName")
	}
}
