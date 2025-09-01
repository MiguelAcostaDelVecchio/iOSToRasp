//
//  DeviceInformation.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/8/24.
//

import SwiftUI
import CoreBluetooth

struct DeviceInformationView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var SelectedGPIOPin = 0
    @State private var possibleGPIOPins = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]
    var peripheral: CBPeripheral
    
    let knownServices: [CBUUID: String] = [
        CBUUID.fromLocalizedKey("gpio_control_service"): "GPIO Control Service"
    ]

    let knownCharacteristics: [CBUUID: String] = [
        CBUUID.fromLocalizedKey("toggle_gpio_pin"): "Toggle GPIO Pin"
    ]
    
    @State private var displayCharacteristicsSheet: Bool = false
    @State private var selectedService: CBService? = nil
    
    var body: some View {
        NavigationStack {
            List {
                Section("Device Information") {
                    Text("Peripheral Name/Identifier: ").bold() + Text("\(peripheral.name ?? peripheral.identifier.uuidString)")
                    Text("Peripheral Description (if any): ").bold() + Text("\(peripheral.description)")
                    Text("Peripheral State: ").bold() + Text(peripheral.state == .connected ? "Connected" : "Disconnected")
                    
                    Button {
                        bluetoothViewModel.disconnect(from: peripheral)
                        dismiss()
                    } label: {
                        Text("Disconnect")
                    }
                }
                
                Section("Services (Click to see Characteristics)") {
                    if let services = peripheral.services {
                        ForEach(services, id: \.self) { service in
                            Button {
                                selectedService = service
                                displayCharacteristicsSheet = true
                            } label: {
                                let label = knownServices[service.uuid] ?? "\(service.uuid)"
                                Text("\(label) (\(service.uuid.uuidString))")
                            }
                        }
                    }
                }
                
                Section("Interact With Device") {
                    Menu {
                        ForEach(possibleGPIOPins, id: \.self) { GPIOpin in
                            Button {
                                SelectedGPIOPin = GPIOpin
                            } label: {
                                Text("GPIO \(GPIOpin)")
                            }

                        }
                    } label: {
                        HStack {
                            Text("Choose GPIO Pin To Toggle")
                            Spacer()
                            if SelectedGPIOPin != 0 {
                                Text("GPIO \(SelectedGPIOPin)")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    if SelectedGPIOPin != 0 {
                        HStack {
                            Spacer()
                            Button {
                                let data = Data([UInt8(SelectedGPIOPin)])
                                bluetoothViewModel.writeToPeripheral(peripheral: peripheral, data: data)
                            } label: {
                                Image(systemName: "lightbulb")
                                Text("Toggle GPIO-\(SelectedGPIOPin)")
                            } // end of button
                            .buttonStyle(.bordered)
                            Spacer()
                        }
                    }
                } // end of Section
                
            } // end of form
            .navigationTitle("Device Information")
        }
        .sheet(isPresented: $displayCharacteristicsSheet) {
            if let selectedService = selectedService {
                CharacteristicsView(service: selectedService)
            } else {
                Text("No service selected.")
            }
        }
    }
}
