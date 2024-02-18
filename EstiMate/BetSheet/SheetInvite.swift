//
//  SheetInvite.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetInvite: View {
    let namespace: Namespace.ID
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus

    @State var betInvited = BetInvited.shared
    @AppStorage("fullName") var fullName: String = ""

    @State var showShare = false

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "link.badge.plus")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("Invite Friends")
                    .font(.system(size: 16).weight(.bold))
            }
            .matchedGeometryEffect(id: "indicator", in: namespace)
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            VStack(alignment: .leading, spacing: 20) {
                ForEach(betInvited.list, id: \.self) { name in
                    Text(name)
                        .font(.system(size: 18).weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.leading, 30)
            .padding(.bottom, 30)

            HStack(spacing: 12) {
                Button {
                    showShare.toggle()
                } label: {
                    Text("Share")
                        .foregroundStyle(.black.opacity(0.6))
                        .font(.system(size: 20, design: .rounded).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hexadecimal: "F4F4F4"))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .inset(by: 1)
                                .stroke(Color(red: 0.80, green: 0.80, blue: 0.80), lineWidth: 2)
                        )
                }
                .sheet(isPresented: $showShare) {
                    ActivityViewController(url: URL(string: "estimate://bet/\(AllBets.shared.recentAddBetID!.uuidString)")!)
                }

                Button {
                    if let bet = AllBets.shared.getBet(by: AllBets.shared.recentAddBetID!.uuidString) {
                        status = .side(bet: bet)
                    }
                } label: {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.accent)
                        .overlay {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 20).weight(.bold))
                                .foregroundStyle(.white)
                        }
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .onAppear {
            betInvited.reset(with: fullName)
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
