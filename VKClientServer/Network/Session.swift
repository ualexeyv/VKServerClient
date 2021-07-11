//
//  Session.swift
//  VKClientServer
//
//  Created by пользовтель on 06.07.2021.
//

import UIKit

class Session {
    static let shared = Session()
    private init() {}
    var token: String = ""
    var userId: Int = 7831620
}

