//
//  PeripheralButton.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/8/24.
//

import SwiftUI
import CoreBluetooth

struct PeripheralButton: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    var peripheral: CBPeripheral
    @State private var isConnecting: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(peripheral.name ?? peripheral.identifier.uuidString)
                Text(peripheral.state == .connected ? "Connected" : "Disconnected")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if isConnecting && peripheral.state != .connected {
                ProgressView()
            } else {
                Button(action: {
                    if peripheral.state == .connected {
                        // bluetoothViewModel.disconnect(from: peripheral)
                    } else {
                        isConnecting = true
                        bluetoothViewModel.connect(to: peripheral)
                    }
                }) {
                    Text(peripheral.state == .connected ? "" : "Connect")
                        .foregroundColor(.blue)
                }
            }
        }
        .onChange(of: peripheral.state) { newState in
            if newState != .connecting {
                isConnecting = false
            }
        }
    }
}
