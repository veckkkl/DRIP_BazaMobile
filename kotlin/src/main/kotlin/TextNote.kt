import java.time.Instant

class TextNote(
    data: TextNoteModel,
    storage: Storage<TextNoteModel>,
    dateFormatter: DateFormatting
) : Note<TextNoteModel>(data, storage, dateFormatter), AnyNote {

    override fun drawCanvas(): String {
        val m = storage.valueById(id) ?: data
        return """
        [Текстовая заметка]
        • id: $id
        • название: ${m.name}
        • текст заметки: ${m.text}
        • создано: ${dateFormatter.format(m.createdAt)}
        • изменено: ${dateFormatter.format(m.updatedAt)}
        """.trimIndent()
    }

    fun rename(newName: String) {
        val m = (storage.valueById(id) ?: data).copy(name = newName, updatedAt = Instant.now())
        update(m)
    }

    fun updateText(newText: String) {
        val m = (storage.valueById(id) ?: data).copy(text = newText, updatedAt = Instant.now())
        update(m)
    }
}
