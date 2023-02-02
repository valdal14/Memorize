//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Valerio D'ALESSIO on 2/2/23.
//

import XCTest

@testable import Memorize

final class MemorizeTests: XCTestCase {
	
	
	func test_shuffleDeck_cardModelGenerationForEmoji() {
		let sut = DeckViewModel(deckGenerator: DeckGenerator())
		let deckOne = sut.shuffleDeck(selectedType: .emoji(.animal), difficultyLevel: .easy)
		let deckTwo = sut.shuffleDeck(selectedType: .emoji(.travel), difficultyLevel: .medium)
		let deckThree = sut.shuffleDeck(selectedType: .emoji(.animal), difficultyLevel: .hard)
		
		XCTAssertEqual(deckOne.count, 6, "Deck size is not the same")
		XCTAssertEqual(deckTwo.count, 9, "Deck size is not the same")
		XCTAssertEqual(deckThree.count, 12, "Deck size is not the same")
	}

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
