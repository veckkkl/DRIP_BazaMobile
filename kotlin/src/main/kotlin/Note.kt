open class Note<Data : Identifiable>(
    data: Data,
    val storage: Storage<Data>,
    val dateFormatter: DateFormatting
) : CanvasUnit {

    var data: Data = data
        private set(value) {
            field = value
            storage.add(value)
        }

    init { storage.add(data) }

    open fun update(newData: Data) { this.data = newData }

    open fun willRemove() { storage.remove(data.id) }

    override fun drawCanvas(): String =
        "Note<${data::class.simpleName}> id=${data.id}"

    val id: String get() = data.id
}

interface AnyNote : CanvasUnit {
    val id: String
    fun willRemove()
}
