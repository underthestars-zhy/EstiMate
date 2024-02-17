//
//  EstiMateApp.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

@main
struct EstiMateApp: App {
    @AppStorage("userID") var userID: String = ""

    var body: some Scene {
        WindowGroup {
            Group {
                if userID.isEmpty {
                    WelcomeView()
                } else {
                    ContentView()
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}
