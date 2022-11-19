//
//  GroupIDGenerator.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/21.
//

import Foundation

struct GroupIDGenerator {
    static func generator(_ length: Int = 10) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 0 ..< length {
            randomString += String(letters.randomElement()!)
        }
        return randomString
    }
}
