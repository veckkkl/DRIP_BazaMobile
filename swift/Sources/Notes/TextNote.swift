import Foundation

final class TextNote: Note<TextNoteModel>, AnyNote {
    override func drawCanvas() -> String {
        let m = storage.value(by: id) ?? data
        return """
        [Текстовая заметка]
        • id: \(id)
        • название: \(m.name)
        • текст заметки: \(m.text)
        • создано: \(dateFormatter.format(m.createdAt))
        • изменено: \(dateFormatter.format(m.updatedAt))
        """
    }

    func rename(_ newName: String) {
        var m = storage.value(by: id) ?? data
        m.name = newName
        m.updatedAt = Date()
        update(m)
    }

    func updateText(_ newText: String) {
        var m = storage.value(by: id) ?? data
        m.text = newText
        m.updatedAt = Date()
        update(m)
    }
}
