import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var viewModel: BonsaiProfilesViewModel
    @Environment(\.presentationMode) var presentationMode

    var profile: BonsaiProfile

    // Local state variables for editing
    @State private var speciesName: String
    @State private var startDate: Date
    @State private var notes: String
    @State private var showDeleteConfirmation = false // Add this state variable

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
            Section(header: Text("Deep Link")) {
                if let url = URL(string: "bonsaiapp://\(profile.id.uuidString)") {
                    Text(url.absoluteString)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = url.absoluteString
                            }) {
                                Text("Copy Link")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                }
            }
            // Add a delete button at the bottom
            Section {
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Text("Delete Profile")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Profile Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Profile", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteProfile(profile)
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this profile? This action cannot be undone.")
        }
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
                Menu {
                    Button(role: .destructive, action: {
                        showDeleteConfirmation = true
                    }) {
                        Label("Delete Profile", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
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
