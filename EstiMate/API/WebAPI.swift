//
//  WebAPI.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation
import SwiftyJSON

struct WebAPI {
    static func checkPermission() async throws {
        guard let URL = URL(string: "https://apple.com") else { return }

        let (_, _) = try await URLSession.shared.data(from: URL)
    }


    static func createAccount(name: String, id: String) async throws -> Bool {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/create-user") else { return false }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let token = UserDefaults.standard.string(forKey: "pushNotificationToken") ?? ""

        // JSON Body

        let bodyObject: [String : Any] = [
            "name": name,
            "userId": id,
            "deviceToken": token
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }

    static func generateEmoji(sentence: String) async throws -> String {
        guard let URL = URL(string: "https://api.together.xyz/v1/chat/completions") else { return "🚫" }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("Bearer dffffdd6f8979cb1d1952b9b0e97450aeab9bc53f73c6b927d847a98ff99156b", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // JSON Body

        let bodyObject: [String : Any] = [
            "model": "mistralai/Mixtral-8x7B-Instruct-v0.1",
            "max_tokens": 1024,
            "messages": [
                [
                    "content": "You are an tool which gives out emoji for specific sentences. You can only reply in emoji.",
                    "role": "system"
                ],
                [
                    "content": "Give me **just only one emoji** in the form of to describe the following sentence without any explanation or text in your response: \"\(sentence)\".",
                    "role": "user"
                ]
            ]
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return "🚫"
        }

        func firstEmoji(in text: String) -> String? {
            for character in text {
                if character.unicodeScalars.allSatisfy({ $0.properties.isEmoji }) {
                    return String(character)
                }
            }
            return nil
        }

        let json = try JSON(data: data)

        print(json["choices"].arrayValue.first?["message"]["content"].stringValue ?? "Wrong")
        let text = json["choices"].arrayValue.first?["message"]["content"].stringValue ?? "🚫"
        print(firstEmoji(in: text) ?? "Wrong")

        return firstEmoji(in: text) ?? "🚫"
    }

    static func createBet(bet: Bet) async throws -> Bool {
        guard var URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/create-bet") else { return false }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        // JSON Body

        let bodyObject: [String : Any] = [
            "amountBet": bet.amount,
            "betName":  bet.title,
            "expiry":  bet.end.timeIntervalSince1970,
            "emoji":  bet.emoji,
            "userId": UserDefaults.standard.string(forKey: "userID") ?? "",
            "betID": bet.id.uuidString
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }
}

