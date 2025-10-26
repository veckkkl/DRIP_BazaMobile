import java.time.Instant

class ReminderNote(
    data: ReminderNoteModel,
    storage: Storage<ReminderNoteModel>,
    dateFormatter: DateFormatting
) : Note<ReminderNoteModel>(data, storage, dateFormatter), AnyNote {

    override fun drawCanvas(): String {
        val m = storage.valueById(id) ?: data
        val status = if (m.isDone) "выполнено" else "в процессе выполнения"
        return """
        [Напоминание]
        • id: $id
        • текст: ${m.text}
        • статус: $status
        • создано: ${dateFormatter.format(m.createdAt)}
        • изменено: ${dateFormatter.format(m.updatedAt)}
        """.trimIndent()
    }

    fun toggle() {
        val current = storage.valueById(id) ?: data
        val m = current.copy(isDone = !current.isDone, updatedAt = Instant.now())
        update(m)
    }

    fun updateText(newText: String) {
        val m = (storage.valueById(id) ?: data).copy(text = newText, updatedAt = Instant.now())
        update(m)
    }
}
