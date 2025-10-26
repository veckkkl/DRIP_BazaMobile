import Foundation

struct TextNoteModel: IdentifiableModel {
    let id: String
    var name: String
    var text: String
    var createdAt: Date
    var updatedAt: Date
}

struct ReminderNoteModel: IdentifiableModel {
    let id: String
    var text: String
    var isDone: Bool
    var createdAt: Date
    var updatedAt: Date
}
