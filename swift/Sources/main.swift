import Foundation

final class NoteApp {
    func run() {
        let ui = ConsoleUI()
        let notebook = Notebook()
        let menu = Menu(ui: ui, notebook: notebook)
        menu.run()
    }
}

NoteApp().run()
