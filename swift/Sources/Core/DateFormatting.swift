import Foundation

import Foundation

protocol DateFormatting {
    func format(_ date: Date) -> String
}

/// (yyyy-MM-dd HH:mm)
final class SimpleDateFormatter: DateFormatting {
    private let formatter: DateFormatter
    init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
    }
    func format(_ date: Date) -> String {
        formatter.string(from: date)
    }
}

