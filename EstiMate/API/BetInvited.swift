//
//  BetInvited.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation

@Observable
class BetInvited {
    static let shared = BetInvited()

    var list = [String]()

    func reset(with name: String) {
        list = [name]
    }
}
