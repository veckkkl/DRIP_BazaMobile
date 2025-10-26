import Foundation

final class Storage<T: IdentifiableModel> {
    private var items: [T] = []
    
    func add (_ element : T) {
        if let idx = items.firstIndex(where: { $0.id == element.id }) {
            items[idx] = element
        } else {
            items.append(element)
        }
    }
    
    func remove(id: String) {
        items.removeAll { $0.id == id }
    }
    
    func getAll() -> [T] {
        return items
    }
    
    func value(by id: String) -> T? {
        items.first { $0.id == id }
    }
}
