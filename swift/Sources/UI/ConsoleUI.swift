import Foundation

enum Input<T> {
    case value(T)
    case canceled
}

final class ConsoleUI {

    func showMenuList(_ title: String, options: [String]) -> Int? {
        print("\n\(title)")
        for (i, opt) in options.enumerated() {
            print("  \(i + 1). \(opt)")
        }
        print("Введите номер (или q для отмены): ", terminator: "")

        guard let raw = readLine(), !raw.isEmpty else { return nil }
        if raw.lowercased() == "q" { return nil }
        guard let v = Int(raw) else {
            print("Некорректное число")
            return nil
        }
        return v
    }

    func showCanvas(_ canvas: CanvasUnit) {
        print("\n" + canvas.drawCanvas())
    }

    func readString(prompt: String = "Введите строку (или q для отмены)") -> Input<String> {
        print("\(prompt): ", terminator: "")
        guard let raw = readLine(), !raw.isEmpty else { return .canceled }
        if raw.lowercased() == "q" { return .canceled }
        return .value(raw)
    }

    func readInt(prompt: String = "Введите число (или q для отмены)") -> Input<Int> {
        print("\(prompt): ", terminator: "")
        guard let raw = readLine(), !raw.isEmpty else { return .canceled }
        if raw.lowercased() == "q" { return .canceled }
        guard let num = Int(raw) else {
            print("Некорректное число")
            return .canceled
        }
        return .value(num)
    }
}
