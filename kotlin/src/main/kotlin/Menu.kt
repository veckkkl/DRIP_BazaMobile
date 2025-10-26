import java.time.Instant

class Menu(
    private val ui: ConsoleUI,
    private val notebook: Notebook
) {
    private val textStorage = Storage<TextNoteModel>()
    private val reminderStorage = Storage<ReminderNoteModel>()
    private val formatter = SimpleDateFormatter()

    fun run() {
        var running = true
        while (running) {
            ui.showCanvas(notebook)
            when (ui.showMenuList(
                "Главное меню",
                listOf("Показать все заметки", "Редактировать заметку", "Добавить новую заметку", "Удалить заметку", "Выход")
            )) {
                1    -> ui.showCanvas(notebook)
                2    -> editNoteFlow()
                3    -> addNoteFlow()
                4    -> deleteNoteFlow()
                5    -> running = false
                else -> println("Некорректный выбор. Повторите")
            }
        }
        println("Сеанс закончен")
    }

    private fun addNoteFlow() {
        when (ui.showMenuList("Какой тип заметки создать?", listOf("Текстовая заметка", "Напоминание"))) {
            1 -> {
                val name = when (val r = ui.readString("Введите имя заметки (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Создание отменено"); return }
                }
                val text = when (val r = ui.readString("Введите текст заметки (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Создание отменено"); return }
                }
                val id = java.util.UUID.randomUUID().toString()
                val now = Instant.now()
                val model = TextNoteModel(id, name, text, now, now)
                val note = TextNote(model, textStorage, formatter)
                notebook.add(note)
            }
            2 -> {
                val text = when (val r = ui.readString("Введите текст напоминания (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Создание отменено"); return }
                }
                val id = java.util.UUID.randomUUID().toString()
                val now = Instant.now()
                val model = ReminderNoteModel(id, text, false, now, now)
                val note = ReminderNote(model, reminderStorage, formatter)
                notebook.add(note)
            }
            else -> println("Тип не выбран")
        }
    }

    private fun editNoteFlow() {
        if (notebook.count == 0) { println("Редактировать нечего, тк заметок нет"); return }
        ui.showCanvas(notebook)

        val idx = when (val r = ui.readInt("Введите номер заметки для редактирования (1-${notebook.count})")) {
            is Input.Value -> r.v
            Input.Canceled -> { println("Операция отменена."); return }
        }
        if (idx !in 1..notebook.count) { println("Некорректный номер"); return }

        val note = notebook[idx - 1] ?: run { println("Не найдено"); return }

        when (note) {
            is TextNote     -> editTextNote(note)
            is ReminderNote -> editReminderNote(note)
            else            -> println("Неизвестный тип заметки")
        }
    }

    private fun editTextNote(note: TextNote) {
        when (ui.showMenuList("Текстовая заметка — действия", listOf("Переименовать", "Изменить текст", "Показать"))) {
            1 -> {
                val name = when (val r = ui.readString("Новое имя (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Изменение отменено"); return }
                }
                note.rename(name)
            }
            2 -> {
                val text = when (val r = ui.readString("Новый текст (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Изменение отменено"); return }
                }
                note.updateText(text)
            }
            3 -> ui.showCanvas(note)
            else -> println("Отмена/неизвестная команда")
        }
    }

    private fun editReminderNote(note: ReminderNote) {
        when (ui.showMenuList("Напоминание — действия", listOf("Переключить статус (done/pending)", "Изменить текст", "Показать"))) {
            1 -> note.toggle()
            2 -> {
                val text = when (val r = ui.readString("Новый текст (или q для отмены)")) {
                    is Input.Value -> r.v
                    Input.Canceled -> { println("Изменение отменено"); return }
                }
                note.updateText(text)
            }
            3 -> ui.showCanvas(note)
            else -> println("Отмена/неизвестная команда")
        }
    }

    private fun deleteNoteFlow() {
        if (notebook.count == 0) { println("Удалять нечего, тк заметок нет"); return }
        ui.showCanvas(notebook)

        val idx = when (val r = ui.readInt("Введите номер заметки для удаления (1-${notebook.count})")) {
            is Input.Value -> r.v
            Input.Canceled -> { println("Операция отменена"); return }
        }
        if (idx !in 1..notebook.count) { println("Некорректный номер"); return }

        notebook.remove(idx - 1)
    }
}
