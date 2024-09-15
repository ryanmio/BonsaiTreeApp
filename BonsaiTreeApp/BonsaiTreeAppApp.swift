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
        }
    }
}
