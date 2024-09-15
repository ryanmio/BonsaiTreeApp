import Foundation

class BonsaiProfilesViewModel: ObservableObject {
    @Published var profiles: [BonsaiProfile] = []

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        loadProfiles()
    }

    func addProfile(_ profile: BonsaiProfile) {
        profiles.append(profile)
        saveProfiles()
    }

    func updateProfile(_ updatedProfile: BonsaiProfile) {
        if let index = profiles.firstIndex(where: { $0.id == updatedProfile.id }) {
            profiles[index] = updatedProfile
            saveProfiles()
        }
    }

    func saveProfiles() {
        if let encodedData = try? encoder.encode(profiles) {
            UserDefaults.standard.set(encodedData, forKey: "profiles")
        }
    }

    func loadProfiles() {
        if let savedData = UserDefaults.standard.data(forKey: "profiles"),
           let decodedProfiles = try? decoder.decode([BonsaiProfile].self, from: savedData) {
            profiles = decodedProfiles
        }
    }
}