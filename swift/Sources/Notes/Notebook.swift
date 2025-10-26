import Foundation

protocol AnyNote: CanvasUnit {
    var id: String { get }
    func willRemove()
}

final class Notebook: CanvasUnit {
    private var notes: [AnyNote] = []

    func add(_ note: AnyNote) {
        notes.append(note)
    }

    func remove(at index: Int) {
        guard notes.indices.contains(index) else { return }
        let note = notes[index]
        note.willRemove()
        notes.remove(at: index)
    }

    var count: Int { notes.count }

    subscript(index: Int) -> AnyNote? {
        notes.indices.contains(index) ? notes[index] : nil
    }

    func drawCanvas() -> String {
        if notes.isEmpty {
            return "Заметок пока нет"
        }
        let lines = notes.enumerated().map { idx, note in
            let header = "— [\(idx + 1)] —"
            return """
            \(header)
            \(note.drawCanvas())
            """
        }
        return lines.joined(separator: "\n\n")
    }
}

