import Foundation

final class ReminderNote: Note<ReminderNoteModel>, AnyNote {
    override func drawCanvas() -> String {
        let m = storage.value(by: id) ?? data
        let status = m.isDone ? "выполнено" : "в процессе выполнения"
        return """
        [Напомиание]
        • id: \(id)
        • текст: \(m.text)
        • статус: \(status)
        • создано: \(dateFormatter.format(m.createdAt))
        • изменено: \(dateFormatter.format(m.updatedAt))
        """
    }

    func toggle() {
        var m = storage.value(by: id) ?? data
        m.isDone.toggle()
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
