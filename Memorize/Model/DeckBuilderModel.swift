//
//  DeckBuilderModel.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 31/1/23.
//

protocol DeckPreview {
	static func selectCardOption() -> [String]
}

struct EmojiStorage: DeckPreview {
	private static let maxDeckSize = 12
	static let animalDeck: [String] = ["🐸", "🦁", "🐼", "🦄", "🐷", "🐭", "🐨", "🦊", "🐮", "🐿", "🐰", "😺"]
	static let travelDeck: [String] = ["✈️", "🚗", "🚎", "🛳", "🚁", "🚂", "🏍", "🚲", "🗼", "🚖", "🚡", "🛻"]
	static let sportDeck: [String] = ["⚽️", "🏀", "🛼", "⚾️", "🎾", "🏐", "🎲", "🎱", "🏓", "⛳️", "🥋", "🥌"]
	
	static func selectCardOption() -> [String] {
		var array: [String] = []
		let index = Int.random(in: 0..<maxDeckSize)
		array.append(EmojiStorage.animalDeck[index])
		array.append(EmojiStorage.travelDeck[index])
		array.append(EmojiStorage.sportDeck[index])
		return array
	}
}

struct SymbolStorage: DeckPreview {
	private static let maxDeckSize = 12
	
	static let gamingDeck: [String] = ["gamecontroller.fill",
									   "playstation.logo",
									   "xbox.logo",
									   "dpad.fill",
									   "flag.2.crossed.fill",
									   "circle.grid.cross.fill",
									   "circle.circle.fill",
									   "triangle.circle.fill",
									   "square.circle.fill",
									   "house.circle.fill",
									   "flag.checkered",
									   "r.joystick.tilt.left.fill"]
	
	static let natureDeck: [String] = ["tree.fill",
									   "camera.macro",
									   "leaf.fill",
									   "tortoise.fill",
									   "hare.fill",
									   "ladybug.fill",
									   "fossil.shell.fill",
									   "mountain.2.fill",
									   "smoke.fill",
									   "cloud.snow.fill",
									   "bird.fill",
									   "microbe.fill"]
	
	static let deviceDeck: [String] = ["display",
										"macpro.gen1.fill",
										"macpro.gen2.fill",
										"macstudio.fill",
										"magicmouse.fill",
										"applewatch.side.right",
										"airpodsmax",
										"airpods",
										"earbuds.case.fill",
										"beats.studiobuds.chargingcase.fill",
										"appletv.fill",
										"homepod"]
	
	static func selectCardOption() -> [String] {
		var array: [String] = []
		let index = Int.random(in: 0..<maxDeckSize)
		array.append(SymbolStorage.gamingDeck[index])
		array.append(SymbolStorage.natureDeck[index])
		array.append(SymbolStorage.deviceDeck[index])
		return array
	}
}

struct PictureStorage {
	static let pictureDeck: [String] = []
}

enum GameLevel: Int, CaseIterable {
	case easy = 6
	case medium = 9
	case hard = 12
}

enum CardType {
	case emoji(EmojiOption)
	case symbol(SymbolOption)
	case picture(PictureOption)
	
	var symbols: [String] {
		switch self {
		case .emoji(let card):
			switch card {
			case .animal:
				return EmojiOption.animal.symbols
			case .travel:
				return EmojiOption.travel.symbols
			case .sport:
				return EmojiOption.sport.symbols
			}
		case .symbol(let card):
			switch card {
			case .nature:
				return SymbolOption.nature.symbols
			case .gaming:
				return SymbolOption.gaming.symbols
			case .device:
				return SymbolOption.device.symbols
			}
		case .picture(let card):
			switch card {
			case .image:
				return PictureOption.image.symbols
			}
		}
	}
}

enum EmojiOption: String {
	case animal = "🦁"
	case travel = "✈️"
	case sport = "⚽️"
	
	
	var symbols: [String] {
		switch self {
		case .animal:
			return EmojiStorage.animalDeck
		case .travel:
			return EmojiStorage.travelDeck
		case .sport:
			return EmojiStorage.sportDeck
		}
	}
}

enum SymbolOption: String {
	case gaming = "xbox.logo"
	case nature = "tree.fill"
	case device = "airpodsmax"
	
	var symbols: [String] {
		switch self {
		case .gaming:
			return SymbolStorage.gamingDeck
		case .nature:
			return SymbolStorage.natureDeck
		case .device:
			return SymbolStorage.deviceDeck
		}
	}
}

enum PictureOption: String {
	case image = ""
	
	var symbols: [String] {
		switch self {
		case .image:
			return PictureStorage.pictureDeck
		}
	}
}





