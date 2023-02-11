//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 31/1/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let persistenceController = PersistenceController.shared
	let audioPlayer = AudioService()
	
    var body: some Scene {
        WindowGroup {
			UserSelectionView()
				.onAppear {
					try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
				}
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
				.environmentObject(audioPlayer)
        }
    }
}
