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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(peripheral.name ?? peripheral.identifier.uuidString)
                Text(peripheral.state == .connected ? "Connected" : "Disconnected")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                if peripheral.state == .connected {
                    //bluetoothViewModel.disconnect(from: peripheral)
                } else {
                    bluetoothViewModel.connect(to: peripheral)
                }
            }) {
                Text(peripheral.state == .connected ? "" : "Connect")
                    .foregroundColor(.blue)
            }
        } // end of Hstack
    }
}

