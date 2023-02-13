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
	@StateObject var audioPlayer = AudioService()
	@State private var wasGameResetAfterSave: Bool = false
    var body: some Scene {
        WindowGroup {
			UserSelectionView(resetStateAfterSave: $wasGameResetAfterSave)
				.onAppear {
					try? audioPlayer.playBackgroundMusic(fileName: "soundtrack", fileExtension: "mp3")
				}
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
				.environmentObject(audioPlayer)
        }
    }
}
