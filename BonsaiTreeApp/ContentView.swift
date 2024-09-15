//
//  ContentView.swift
//  BonsaiTreeApp
//
//  Created by Ryan Mioduski iMac on 9/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var isShowingProfile = false
    @State private var selectedProfile: BonsaiProfile? = nil // For deep linking

    @EnvironmentObject var viewModel: BonsaiProfilesViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.profiles) { profile in
                        NavigationLink(destination: ProfileDetailView(profile: profile)
                                        .environmentObject(viewModel)) {
                            Text(profile.speciesName)
                        }
                    }
                }
                Spacer()

                Button(action: {
                    isShowingScanner = true
                }) {
                    Text("Scan")
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Bonsai Tree App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingProfile = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                // ScannerView() // Optional: Implement if you decide to keep scanning
            }
            .sheet(isPresented: $isShowingProfile) {
                NavigationView {
                    ProfileView()
                        .environmentObject(viewModel)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .openProfile)) { notification in
                if let profile = notification.object as? BonsaiProfile {
                    selectedProfile = profile
                }
            }
            .background(
                NavigationLink(
                    destination: ProfileDetailView(profile: selectedProfile ?? viewModel.profiles.first!)
                        .environmentObject(viewModel),
                    isActive: Binding(
                        get: { selectedProfile != nil },
                        set: { if !$0 { selectedProfile = nil } }
                    )
                ) {
                    EmptyView()
                }
            )
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(BonsaiProfilesViewModel())
        }
    }
}

extension Notification.Name {
    static let openProfile = Notification.Name("OpenProfile")
}
