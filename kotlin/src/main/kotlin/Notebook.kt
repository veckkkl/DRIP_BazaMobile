class Notebook : CanvasUnit {
    private val notes = mutableListOf<AnyNote>()

    fun add(note: AnyNote) { notes.add(note) }

    fun remove(index: Int) {
        if (index in notes.indices) {
            notes[index].willRemove()
            notes.removeAt(index)
        }
    }

    val count: Int get() = notes.size
    operator fun get(index: Int): AnyNote? = notes.getOrNull(index)

    override fun drawCanvas(): String {
        if (notes.isEmpty()) return "Заметок пока нет."
        return notes.mapIndexed { idx, n ->
            "— [${idx + 1}] —\n${n.drawCanvas()}"
        }.joinToString("\n\n")
    }
}
