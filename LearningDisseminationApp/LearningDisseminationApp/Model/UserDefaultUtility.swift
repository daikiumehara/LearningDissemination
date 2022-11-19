//
//  UserDefaultUtility.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/26.
//

import Foundation

enum UserDefaultsKey: String {
    case accountID
    case groupID
}

extension UserDefaults {
    func setValue(_ value: Any?, forKey key: UserDefaultsKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }

    func object(forKey key: UserDefaultsKey) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }

    func removeObject(forkey key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
