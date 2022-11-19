//
//  CustomDateFormatter.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/21.
//

import Foundation

struct CustomDataFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d H:m:s"
        return formatter
    }()

    static func date(_ string: String) -> Date {
        guard let date = formatter.date(from: string) else {
            fatalError("Dateの変換に失敗しました")
        }
        return date
    }

    static func string(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}
