//
//  SheetStatus.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation
import SwiftUI
import SwiftUIX

enum SheetStatus {
    case bottom
    case input
    case time
    case amount
    case invite

    var needPadding: Bool {
        switch self {
        case .bottom, .input: false
        default: true
        }
    }
}
