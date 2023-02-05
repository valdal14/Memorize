//
//  Game+CoreDataProperties.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var currentState: [Card]?
    @NSManaged public var user: Player?

}

extension Game : Identifiable {

}
