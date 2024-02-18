//
//  WelcomeView.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import AuthenticationServices

struct WelcomeView: View {
    @AppStorage("userID") var userID: String = ""
    @AppStorage("fullName") var fullName: String = ""

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 40) {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)

                Group {
                    Text("Esti").foregroundStyle(.black) + Text("Mate").foregroundStyle(.accent)
                }
                .font(.system(size: 40, design: .rounded))
                .bold()
            }
            .padding(.top, 120)

            TabView {
                GuideItem(title: "Friends Fueled Fun", color: "46D123", image: "digitalcrown.horizontal.arrow.counterclockwise.fill", text: "Bring your friends together and place your bets on everyday occurrences, from weather to campus events. Just bring your phones close to confirm your guesses and let the fun begin!")

                GuideItem(title: "Earn from Bets", color: "F0D029", image: "bitcoinsign.circle.fill", text: "Start with 100 Bet Coins as a welcome bonus and watch your balance grow with every successful prediction. Use your winnings to place more bets or withdraw them to celebrate your success.")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            Spacer()

            VStack(spacing: 20) {
                SignInWithAppleButton(.continue) { request in
                    request.requestedScopes = [.fullName]
                } onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Authorisation successful")
                        if let appleIDCredential =  authResults.credential as? ASAuthorizationAppleIDCredential {
                            let fullName = if let fullName = appleIDCredential.fullName {
                                PersonNameComponentsFormatter().string(from: fullName)
                            } else {
                                "Unknown"
                            }
                            let userIdentifier = appleIDCredential.user

                            print(fullName, userIdentifier)

                            self.fullName = fullName

                            Task {
                                if try await WebAPI.createAccount(name: fullName, id: userIdentifier) {
                                    userID = userIdentifier
                                }
                            }
                        } else {
                            print("Authorisation failed: Cannot get ID")
                        }
                    case .failure(let error):
                        print("Authorisation failed: \(error.localizedDescription)")
                    }
                }
                .signInWithAppleButtonStyle(.black)
                .cornerRadius(27)
                .frame(height: 54)

                Group {
                    Text("By proceeding, ") + Text("an automatic creation of a Web3 Wallet account will occur").underline(pattern: .solid) + Text(", enabling you to store your Bet Coins.")
                }
                .font(Font.system(size: 14).weight(.medium))
                .foregroundStyle(Color(hexadecimal: "4D4D4D"))
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    WelcomeView()
        .ignoresSafeArea(.all)
}
