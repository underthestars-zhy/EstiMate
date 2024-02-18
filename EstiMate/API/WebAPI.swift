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
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/create-bet") else { return false }
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

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }

    static func getBet(by betID: String) async throws -> Bet? {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/bet/\(betID)") else { return nil }

        let (data, response) = try await URLSession.shared.data(from: URL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }

        let json = try JSON(data: data)

        func calStatus() -> BetStatus {
            if json["id"]["isSettled"].boolValue {
                return .done
            } else {
                return .inProgress
            }
        }

        return Bet(id: UUID(uuidString: json["id"]["betId"].stringValue) ?? UUID(), title: json["id"]["desc"].stringValue, emoji: json["id"]["emoji"].stringValue, start: Date(timeIntervalSince1970: TimeInterval(json["id"]["createdAt"].intValue)), end: Date(timeIntervalSince1970: TimeInterval(json["id"]["expiry"].intValue)), amount: json["id"]["amount"].doubleValue, status: calStatus())
    }

    static func setSide(betID: String, side: Bool) async throws -> Bool {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/set-side") else { return false }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        // JSON Body

        let bodyObject: [String : Any] = [
            "betId": betID,
            "userId": UserDefaults.standard.string(forKey: "userID") ?? "",
            "side": side
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }

//    func getBetCoints() async throws -> Double {
//        
//    }

    static func fetchAllBets() async throws -> [Bet] {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/bets/\(UserDefaults.standard.string(forKey: "userID") ?? "")") else { return [] }

        let (data, response) = try await URLSession.shared.data(from: URL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return []
        }

        let rawJson = try JSON(data: data)

        let betJsonArray = rawJson["bets"].arrayValue

        var results = [Bet]()

        for json in betJsonArray {
            func calStatus() -> BetStatus {
                if json["id"]["isSettled"].boolValue {
                    return .done
                } else {
                    return .inProgress
                }
            }

            results.append(Bet(id: UUID(uuidString: json["betId"].stringValue) ?? UUID(), title: json["desc"].stringValue, emoji: json["emoji"].stringValue, start: Date(timeIntervalSince1970: TimeInterval(json["createdAt"].intValue)), end: Date(timeIntervalSince1970: TimeInterval(json["expiry"].intValue)), amount: json["amount"].doubleValue, status: calStatus()))
        }

        return results
    }

    static func setDeviceToken(token: String) async throws {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/update-device-token") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        // JSON Body

        let bodyObject: [String : Any] = [
            "deviceToken": token,
            "userId": UserDefaults.standard.string(forKey: "userID") ?? "",
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return
        }

    }

    static func joinBet(bet: Bet) async throws -> Bool {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/join-bet/\(UserDefaults.standard.string(forKey: "userID") ?? "")/\(bet.id)") else { return false }

        let (_, response) = try await URLSession.shared.data(from: URL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }

    static func vote(betID: String, side: Bool) async throws -> Bool {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/vote") else { return false }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        // JSON Body

        let bodyObject: [String : Any] = [
            "betId": betID,
            "userId": UserDefaults.standard.string(forKey: "userID") ?? "",
            "side": side
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }

        return true
    }

    static func voted() async throws -> [String] {
        guard let URL = URL(string: "https://b482-68-65-175-21.ngrok-free.app/votes/\(UserDefaults.standard.string(forKey: "userID") ?? "")") else { return [] }

        let (data, response) = try await URLSession.shared.data(from: URL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return []
        }

        let rawJson = try JSON(data: data)

        return rawJson["result"].arrayValue.map(\.stringValue)
    }
}

