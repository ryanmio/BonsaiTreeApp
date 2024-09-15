import Foundation

class BonsaiProfilesViewModel: ObservableObject {
    @Published var profiles: [BonsaiProfile] = []

    // Methods to load, save, add, and delete profiles
    func addProfile(_ profile: BonsaiProfile) {
        profiles.append(profile)
        saveProfiles()
    }

    func saveProfiles() {
        if let encodedData = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(encodedData, forKey: "profiles")
        }
    }

    func loadProfiles() {
        if let savedData = UserDefaults.standard.data(forKey: "profiles"),
           let decodedProfiles = try? JSONDecoder().decode([BonsaiProfile].self, from: savedData) {
            profiles = decodedProfiles
        }
    }
}