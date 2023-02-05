//
//  OnboardingView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 4/2/23.
//

import SwiftUI

struct OnboardingView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@State private var currentTab = 0
	@Binding var showNext: Bool
	
	var body: some View {
		TabView(selection: $currentTab,
				content:  {
			UserSelectionView()
				.tag(0)
			if showNext {
				Text("Second View")
					.tag(1)
				Text("Third View")
					.tag(2)
			}
		})
		.edgesIgnoringSafeArea(.all)
		.tabViewStyle(PageTabViewStyle())
		.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
	}
}

struct OnboardingView_Previews: PreviewProvider {
	@State static var showNext: Bool = false
	static var previews: some View {
		OnboardingView(showNext: $showNext)
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
			.preferredColorScheme(.light)
	}
}

struct DarkOnboardingView_Previews: PreviewProvider {
	@State static var showNext: Bool = false
	static var previews: some View {
		OnboardingView(showNext: $showNext)
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
			.preferredColorScheme(.dark)
	}
}

