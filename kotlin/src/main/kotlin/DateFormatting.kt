import java.time.Instant
import java.time.ZoneId
import java.time.format.DateTimeFormatter

interface DateFormatting {
    fun format(instant: Instant): String
}

class SimpleDateFormatter : DateFormatting {
    private val zone = ZoneId.systemDefault()
    private val fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
    override fun format(instant: Instant): String =
        fmt.format(instant.atZone(zone))
}
