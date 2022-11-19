//
//  FirebaseUtility.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/26.
//

import Foundation
import FirebaseDatabase

struct FirebaseUtility {
    // MARK: Task
    static func makeTask(progress: Int) -> [String: Any] {
        let dateString = CustomDataFormatter.string(Date())
        let task: [String: Any] = [
            "progress": progress,
            "date": dateString
        ]
        return task
    }

    static func setTask(groupID: String, accountID: String, task: [String: Any], completion: @escaping (Error?, DatabaseReference) -> Void) {
        let ref = Database.database().reference()
        ref.child("groups/\(groupID)/members/\(accountID)").childByAutoId().setValue(task) { error, reference in
            guard error == nil else {
                completion(error, reference)
                return
            }
            ref.child("groups/\(groupID)/members/\(accountID)/current").updateChildValues(task) { error, reference in
                completion(error, reference)
            }
        }
    }

    // MARK: History
    static func getHistory(groupID: String, accountID: String, completion: @escaping ([History]?, AppError?) -> Void) {
        let ref = Database.database().reference()
        ref.child("groups/\(groupID)/members/\(accountID)").getData { error, snapshot in
            guard error == nil else {
                completion(nil, AppError(message: "エラーが発生しました"))
                return
            }
            guard let value = snapshot?.value as? [String: Any] else {
                completion(nil, AppError(message: "グループが存在しません"))
                return
            }
            var list = [History]()
            let keys = value.keys
            keys.forEach { key in
                if key.description != "current" {
                    guard let dic = value[key] as? [String: Any] else {
                        return
                    }
                    let history = History(id: key.description,
                                          date: CustomDataFormatter.date(dic["date"] as! String),
                                          progress: dic["progress"] as! Int,
                                          goal: UserCache.group.info.goal)
                    list.append(history)
                }
            }
            list.sort()
            completion(list, nil)
        }
    }

    // MARK: - User
    static func existUser(groupID: String, accoutID: String, completion: @escaping (Bool?, AppError?) -> Void) {
        let ref = Database.database().reference()
        ref.child("groups/\(groupID)/members/\(accoutID)").getData { error, snapshot in
            guard error == nil else {
                completion(nil, AppError(message: "エラーが発生しました"))
                return
            }
            guard let user = snapshot?.value as? [String: Any] else {
                completion(false, nil)
                return
            }
            completion(true, nil)
        }
    }

    static func getUser(accountID: String, completion: @escaping (User?, AppError?) -> Void) {
        let ref = Database.database().reference()
        ref.child("users/\(accountID)").getData { error, snapshot in
            guard error == nil else {
                completion(nil, AppError(message: "エラーが発生しました"))
                return
            }
            guard let userDic = snapshot?.value as? [String: String] else {
                completion(nil, nil)
                return
            }
            let user = User(id: accountID,
                            name: userDic["name"]!,
                            password: userDic["password"]!)
            completion(user, nil)
        }
    }



    // MARK: - Group
    static func getGroup(groupID: String, completion: @escaping (GroupInfo?, AppError?) -> Void) {
        let ref = Database.database().reference()
        ref.child("groups/\(groupID)").getData { error, snapshot in
            guard error == nil else {
                completion(nil, AppError(message: "エラーが発生しました"))
                return
            }
            guard let group = snapshot?.value as? [String: Any] else {
                completion(nil, nil)
                return
            }
            let groupInfo = GroupInfo(id: groupID,
                                  name: group["name"] as! String,
                                  password: group["password"] as! String,
                                  goal: group["task"] as! Int,
                                  unit: group["unit"] as! String)
            completion(groupInfo, nil)
        }
    }


    // MARK: - AllData
    static func getAllData(groupID: String) async -> (Group?, AppError?) {
        let ref = Database.database().reference()
        do {
            let groupDic = try await ref.child("groups/\(groupID)").getData()
            guard let groupDic = groupDic.value as? [String: Any] else {
                return (nil, nil)
            }
            UserCache.group.info.goal = groupDic["task"] as! Int
            UserCache.group.info.unit = groupDic["unit"] as! String

            var users = [User]()
            var infos = [TaskInfo]()

            let membersDic = groupDic["members"] as! [String: Any]
            for key in membersDic.keys {
                let value = membersDic[key] as! [String: Any]
                let dic = value["current"] as! [String: Any]
                let task = TaskProgress(progress: dic["progress"] as! Int,
                                goal: UserCache.group.info.goal,
                                unit: UserCache.group.info.unit)
                let snapshot = try await ref.child("users/\(key)").getData()
                guard let userDic = snapshot.value as? [String: String] else {
                    return (nil, AppError(message: "データの取得に失敗しました"))
                }
                let user = User(id: key, name: userDic["name"]!, password: userDic["password"]!)
                infos.append(TaskInfo(user: user, task: task))
                users.append(user)
            }
            infos.sort()
            var rankings = [Ranking]()
            infos.enumerated().forEach { index, info in
                rankings.append(Ranking(rank: index+1, info: info))
            }
            let group = Group(info: GroupInfo(id: groupID,
                                                  name: groupDic["name"] as! String,
                                                  password: groupDic["password"] as! String,
                                                  goal: groupDic["task"] as! Int,
                                                  unit: groupDic["unit"] as! String),
                                  users: users,
                                  rankings: rankings)

            return (group, nil)
        } catch {
            return (nil, AppError(message: "エラーが発生しました"))
        }
    }
}
