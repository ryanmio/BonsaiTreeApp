import SwiftUI

struct ProfileView: View {
    @State private var speciesName: String = ""
    @State private var startDate: Date = Date()
    @State private var notes: String = "" // Use String for notes

    @EnvironmentObject var viewModel: BonsaiProfilesViewModel
    @Environment(\.presentationMode) var presentationMode

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
        .navigationTitle("Bonsai Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let newProfile = BonsaiProfile(
                        speciesName: speciesName,
                        startDate: startDate,
                        notes: notes
                    )
                    viewModel.addProfile(newProfile)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(BonsaiProfilesViewModel())
    }
}