import Foundation

final class Menu {
    private let ui: ConsoleUI
    private let notebook: Notebook
    private let textStorage = Storage<TextNoteModel>()
    private let reminderStorage = Storage<ReminderNoteModel>()
    private let formatter = SimpleDateFormatter()

    init(ui: ConsoleUI, notebook: Notebook) {
        self.ui = ui
        self.notebook = notebook
    }

    func run() {
        var running = true
        while running {
            ui.showCanvas(notebook)

            let choice = ui.showMenuList("Главное меню", options: [
                "Показать все заметки",
                "Редактировать заметку",
                "Добавить новую заметку",
                "Удалить заметку",
                "Выход"
            ])

            switch choice {
            case 1:
                ui.showCanvas(notebook)

            case 2:
                editNoteFlow()

            case 3:
                addNoteFlow()

            case 4:
                deleteNoteFlow()

            case 5:
                running = false

            default:
                print("Некорректный выбор. Повторите.")
            }
        }
        print("Сеанс завершен")
    }

    // MARK: - Добавление заметки
    private func addNoteFlow() {
        guard let type = ui.showMenuList("Какой тип заметки создать?", options: [
            "Текстовая заметка",
            "напоминание"
        ]) else {
            print("Тип не выбран")
            return
        }

        switch type {
        case 1:
            let id = UUID().uuidString

            let nameInput = ui.readString(prompt: "Введите имя заметки (или q для отмены)")
            guard case let .value(name) = nameInput else {
                print("Создание заметки отменено")
                return
            }

            let textInput = ui.readString(prompt: "Введите текст заметки (или q для отмены)")
            guard case let .value(text) = textInput else {
                print("Создание заметки отменено")
                return
            }

            let now = Date()
            let model = TextNoteModel(id: id, name: name, text: text, createdAt: now, updatedAt: now)
            let note = TextNote(data: model, storage: textStorage, dateFormatter: formatter)
            notebook.add(note)

        case 2:
            let id = UUID().uuidString

            let textInput = ui.readString(prompt: "Введите текст напоминания (или q для отмены)")
            guard case let .value(text) = textInput else {
                print("Создание напоминания отменено")
                return
            }
            let now = Date()
            let model = ReminderNoteModel(id: id, text: text, isDone: false, createdAt: now, updatedAt: now)
            let note = ReminderNote(data: model, storage: reminderStorage, dateFormatter: formatter)
            notebook.add(note)

        default:
            break
        }
    }

    // MARK: - Редактирование заметки
    private func editNoteFlow() {
        guard notebook.count > 0 else {
            print("Редактировать нечего, тк заметок нет")
            return
        }
        ui.showCanvas(notebook)

        let idxInput = ui.readInt(prompt: "Введите номер заметки для редактирования (1-\(notebook.count))")
        guard case let .value(idx) = idxInput,
              (1...notebook.count).contains(idx),
              let note = notebook[idx - 1]
        else {
            print("Некорректный номер или операция отменена")
            return
        }

        if let textNote = note as? TextNote {
            editTextNote(textNote)
        } else if let remNote = note as? ReminderNote {
            editReminderNote(remNote)
        } else {
            print("Неизвестный тип заметки")
        }
    }

    private func editTextNote(_ note: TextNote) {
        let choice = ui.showMenuList("Текстовая заметка — возможные действия", options: [
            "Переименовать",
            "Изменить текст",
            "Показать"
        ])
        switch choice {
        case 1:
            let nameInput = ui.readString(prompt: "Новое имя (или q для отмены)")
            guard case let .value(newName) = nameInput else {
                print("Изменение отменено")
                return
            }
            note.rename(newName)

        case 2:
            let textInput = ui.readString(prompt: "Новый текст (или q для отмены)")
            guard case let .value(newText) = textInput else {
                print("Изменение отменено")
                return
            }
            note.updateText(newText)

        case 3:
            ui.showCanvas(note)

        default:
            print("Отмена/неизвестная команда")
        }
    }

    private func editReminderNote(_ note: ReminderNote) {
        let choice = ui.showMenuList("Напоминание — действия", options: [
            "Переключить статус (выполнено/в процессе)",
            "Изменить текст",
            "Показать"
        ])
        switch choice {
        case 1:
            note.toggle()

        case 2:
            let textInput = ui.readString(prompt: "Новый текст (или q для отмены)")
            guard case let .value(newText) = textInput else {
                print("Изменение отменено")
                return
            }
            note.updateText(newText)

        case 3:
            ui.showCanvas(note)

        default:
            print("Отмена/неизвестная команда")
        }
    }

    // MARK: - Удаление
    private func deleteNoteFlow() {
        guard notebook.count > 0 else {
            print("Удалять нечего, тк заметок нет")
            return
        }
        ui.showCanvas(notebook)

        let idxInput = ui.readInt(prompt: "Введите номер заметки для удаления (1-\(notebook.count))")
        guard case let .value(idx) = idxInput,
              (1...notebook.count).contains(idx)
        else {
            print("Некорректный номер или операция отменена.")
            return
        }

        notebook.remove(at: idx - 1)
    }
}
