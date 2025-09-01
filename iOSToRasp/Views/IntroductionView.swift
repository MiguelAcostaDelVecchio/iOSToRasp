//
//  CategoryView.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 8/31/25.
//

import Combine
import CoreHaptics
import Popovers
import SwiftUI
import UIKit

struct IntroductionView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 2) {
                Image(systemName: "chevron.left.slash.chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.bottom, 20)
                    .foregroundColor(Color.LightIcon)

                Text("Open Source. Fully Yours.")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .foregroundColor(Color.PrimaryText)
                    .multilineTextAlignment(.center)

                Text("RaspPi Boost is an open source project built to help you get more out of your Raspberry Pi.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color.SubtitleText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)

                Text("Control GPIO pins via Bluetooth, send commands, and contribute your own features.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color.SubtitleText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                    .padding(.top, 2)
            }
            .frame(height: UIScreen.main.bounds.height / 3.4, alignment: .bottom)
            .frame(maxWidth: .infinity, alignment: .center)

            VStack(alignment: .center, spacing: 22) {
                Label("Open-souce under GNU General Public License v3.0", systemImage: "checkmark.seal")
                Label("Easy to contribute — SwiftUI, BLE, Raspberry Pi", systemImage: "hammer")
                Label("Build your own modules or improve existing ones", systemImage: "puzzlepiece.extension")

                Link(destination: URL(string: "https://github.com/MiguelAcostaDelVecchio/iOSToRasp")!) {
                    HStack(spacing: 6) {
                        Image(systemName: "link")
                        Text("View on GitHub")
                    }
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.blue.opacity(0.8), lineWidth: 2)
                    )
                }
            }
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(Color.SubtitleText)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            Button(action: {
                dismiss()
            }) {
                Text("Start Using RaspPi Boost")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.LightIcon)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.DarkBackground))
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PrimaryBackground)
    }
}
