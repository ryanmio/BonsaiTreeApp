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
    @StateObject var viewModel = BonsaiProfilesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.profiles) { profile in
                        NavigationLink(destination: ProfileDetailView(profile: profile)) {
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
                ScannerView()
            }
            .sheet(isPresented: $isShowingProfile) {
                NavigationView {
                    ProfileView()
                        .environmentObject(viewModel)
                }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(BonsaiProfilesViewModel())
        }
    }
}
