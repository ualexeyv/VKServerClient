//
//  DBService.swift
//  VKClientServer
//
//  Created by пользовтель on 23.07.2021.
//

import Foundation
import RealmSwift

protocol VKDatabaseProtocol {
    associatedtype T
    func add(_ user: T)
    func read() -> [T]
    func delete(_ user: T)
}

class FriendsDB: VKDatabaseProtocol {
    let config = Realm.Configuration(schemaVersion: 14)
    lazy var mainRealm = try! Realm(configuration: config)
    
    func add(_ user: FriendsModel) {
        mainRealm.beginWrite()
        mainRealm.add(user, update: .modified)
        try! mainRealm.commitWrite()
    }
    
    func read() -> [FriendsModel] {
        let user = mainRealm.objects(FriendsModel.self)
        print(mainRealm.configuration.fileURL)
        return Array(user)
    }
    
    func delete(_ user: FriendsModel) {
        mainRealm.beginWrite()
        mainRealm.delete(user)
        try! mainRealm.commitWrite()
    }
    
}
class GroupsDB: VKDatabaseProtocol {
    let config = Realm.Configuration(schemaVersion: 12)
    lazy var mainRealm = try! Realm(configuration: config)
    
    func add(_ user: GroupsModel) {
        mainRealm.beginWrite()
        mainRealm.add(user, update: .modified)
        try! mainRealm.commitWrite()
    }
    
    func read() -> [GroupsModel] {
        let user = mainRealm.objects(GroupsModel.self)
        print(mainRealm.configuration.fileURL)
        return Array(user)
    }
    
    func delete(_ user: GroupsModel) {
        mainRealm.beginWrite()
        mainRealm.delete(user)
        try! mainRealm.commitWrite()
    }
}
class PhotoDB: VKDatabaseProtocol {
    let config = Realm.Configuration(schemaVersion: 4)
    lazy var mainRealm = try! Realm(configuration: config)
    
    func add(_ user: Photos2) {
        mainRealm.beginWrite()
        mainRealm.add(user, update: .modified)
        try! mainRealm.commitWrite()
    }
    
    func read() -> [Photos2] {
        let user = mainRealm.objects(Photos2.self)
        print(mainRealm.configuration.fileURL)
        return Array(user)
    }
    
    func delete(_ user: Photos2) {
        mainRealm.beginWrite()
        mainRealm.delete(user)
        try! mainRealm.commitWrite()
    }
    
    
}
