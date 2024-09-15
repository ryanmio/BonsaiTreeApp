import Foundation

struct BonsaiProfile: Identifiable, Codable {
    var id: UUID
    var speciesName: String
    var startDate: Date
    var notes: String
}