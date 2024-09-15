//
//  BonsaiTreeAppApp.swift
//  BonsaiTreeApp
//
//  Created by Ryan Mioduski iMac on 9/15/24.
//

import SwiftUI

@main
struct BonsaiTreeAppApp: App {
    @StateObject private var viewModel = BonsaiProfilesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onOpenURL { url in
                    handleDeepLink(url: url)
                }
        }
    }

    func handleDeepLink(url: URL) {
        // Parse the URL to get the profile ID
        guard url.scheme == "bonsaiapp" else { return }

        if let host = url.host,
           let uuid = UUID(uuidString: host),
           let profile = viewModel.profiles.first(where: { $0.id == uuid }) {
            // Navigate to the profile
            // Update the view model or set a state to show the profile
            NotificationCenter.default.post(name: .openProfile, object: profile)
        }
    }
}
