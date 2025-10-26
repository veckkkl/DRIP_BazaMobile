class Storage<T : Identifiable> {
    private val items = mutableListOf<T>()

    fun add(element: T) {
        val idx = items.indexOfFirst { it.id == element.id }
        if (idx >= 0) items[idx] = element else items.add(element)
    }

    fun remove(id: String) {
        items.removeAll { it.id == id }
    }

    fun getAll(): List<T> = items.toList()

    fun valueById(id: String): T? = items.firstOrNull { it.id == id }
}
