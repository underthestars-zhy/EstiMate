//
//  EstiMateApp.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import UserNotifications

@main
struct EstiMateApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @AppStorage("userID") var userID: String = ""

    var body: some Scene {
        WindowGroup {
            VStack {
                if userID.isEmpty {
                    WelcomeView()
                } else {
                    ContentView()
                }
            }
            .task {
                do {
                    //                    userID = ""
                    try await WebAPI.checkPermission()
                } catch {
                    print(error)
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        registerForPushNotifications()

        UIApplication.shared.registerForRemoteNotifications()

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        registryToken(deviceToken: deviceToken)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register: \(error)")
    }

    func registryToken(deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        let pastToken = UserDefaults.standard.string(forKey: "pushNotificationToken")
        if let pastToken {
            print("Past Token: \(pastToken)")
            if pastToken != token {
                UserDefaults.standard.set(token, forKey: "pushNotificationToken")
                Task.detached { try await WebAPI.setDeviceToken(token: token) }
            }
        } else {
            UserDefaults.standard.set(token, forKey: "pushNotificationToken")
        }
        print("Device Token: \(token)")
    }

    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert]) { granted, _ in
                print("Permission granted: \(granted)")
            }
    }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("receive notification")
        print(userInfo)

        switch userInfo["type"] as? String {
        case "join":
            if let name = userInfo["name"] as? String {
                BetInvited.shared.list.append(name)
            }
        case "results":
            if let data = userInfo["data"] as? [AnyHashable: Any],
               let betID = data["betId"] as? String,
               let change = data["change"] as? Double,
               let userSide = data["userside"] as? Bool,
               let voteSide = data["vote"] as? Bool,
               let balance = data["amount"] as? Double {
                let r = BetResult(betID: betID, change: change, userSide: userSide, voteSide: voteSide, balance: balance)
                SheetStatusPublisher.shared.status = .result(betR: r)
            }
        default: break
        }
    }

}
