import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var viewModel: BonsaiProfilesViewModel
    @Environment(\.presentationMode) var presentationMode

    var profile: BonsaiProfile

    // Local state variables for editing
    @State private var speciesName: String
    @State private var startDate: Date
    @State private var notes: String

    init(profile: BonsaiProfile) {
        self.profile = profile
        _speciesName = State(initialValue: profile.speciesName)
        _startDate = State(initialValue: profile.startDate)
        _notes = State(initialValue: profile.notes)
    }

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Species Name", text: $speciesName)
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 200)
                    .border(Color(UIColor.separator))
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save") {
                    let updatedProfile = BonsaiProfile(
                        id: profile.id,
                        speciesName: speciesName,
                        startDate: startDate,
                        notes: notes
                    )
                    viewModel.updateProfile(updatedProfile)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profile: BonsaiProfile(
            id: UUID(),
            speciesName: "Maple",
            startDate: Date(),
            notes: "Needs pruning"
        ))
        .environmentObject(BonsaiProfilesViewModel())
    }
}
