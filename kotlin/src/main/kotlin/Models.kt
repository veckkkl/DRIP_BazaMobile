import java.time.Instant

data class TextNoteModel(
    override val id: String,
    var name: String,
    var text: String,
    var createdAt: Instant,
    var updatedAt: Instant
) : Identifiable

data class ReminderNoteModel(
    override val id: String,
    var text: String,
    var isDone: Boolean,
    var createdAt: Instant,
    var updatedAt: Instant
) : Identifiable
