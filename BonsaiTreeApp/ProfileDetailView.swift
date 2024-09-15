import SwiftUI

struct ProfileDetailView: View {
    @State var profile: BonsaiProfile

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                Text("Species Name: \(profile.speciesName)")
                Text("Start Date: \(profile.startDate, formatter: dateFormatter)")
            }
            Section(header: Text("Notes")) {
                Text(profile.notes)
            }
        }
        .navigationTitle("Profile Details")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profile: BonsaiProfile(speciesName: "Maple", startDate: Date(), notes: "Needs pruning"))
            .environmentObject(BonsaiProfilesViewModel())
    }
}