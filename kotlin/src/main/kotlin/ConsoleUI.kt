sealed class Input<out T> {
    data class Value<T>(val v: T) : Input<T>()
    data object Canceled : Input<Nothing>()
}

class ConsoleUI {

    fun showCanvas(canvas: CanvasUnit) {
        println()
        println(canvas.drawCanvas())
    }

    fun showMenuList(title: String, options: List<String>): Int? {
        println()
        println(title)
        options.forEachIndexed { i, opt -> println("  ${i + 1}. $opt") }
        print("Введите номер (или q для отмены): ")
        val raw = readlnOrNull()?.trim().orEmpty()
        if (raw.isEmpty() || raw.equals("q", ignoreCase = true)) return null
        return raw.toIntOrNull()
    }

    fun readString(prompt: String = "Введите строку (или q для отмены)"): Input<String> {
        print("$prompt: ")
        val raw = readlnOrNull() ?: return Input.Canceled
        if (raw.isEmpty() || raw.equals("q", ignoreCase = true)) return Input.Canceled
        return Input.Value(raw)
    }

    fun readInt(prompt: String = "Введите число (или q для отмены)"): Input<Int> {
        print("$prompt: ")
        val raw = readlnOrNull()?.trim().orEmpty()
        if (raw.isEmpty() || raw.equals("q", ignoreCase = true)) return Input.Canceled
        val n = raw.toIntOrNull() ?: return Input.Canceled
        return Input.Value(n)
    }
}
