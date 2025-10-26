fun main() {
    NoteApp().run()
}

class NoteApp {
    fun run() {
        val ui = ConsoleUI()
        val notebook = Notebook()
        val menu = Menu(ui, notebook)
        menu.run()
    }
}
