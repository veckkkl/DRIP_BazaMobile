import Foundation

class Note<Data: IdentifiableModel>: CanvasUnit {
    let storage: Storage<Data>
    let dateFormatter: DateFormatting
    private(set) var data: Data {
        didSet { storage.add(data) }
    }

    init(data: Data, storage: Storage<Data>, dateFormatter: DateFormatting) {
        self.storage = storage
        self.data = data
        self.dateFormatter = dateFormatter
        storage.add(data)
    }

    func update(_ newData: Data) {
        self.data = newData
    }

    func willRemove() {
        storage.remove(id: data.id)
    }

    func drawCanvas() -> String {
        "Note<\(String(describing: Data.self))> id=\(data.id)"
    }

    var id: String { data.id }
}
