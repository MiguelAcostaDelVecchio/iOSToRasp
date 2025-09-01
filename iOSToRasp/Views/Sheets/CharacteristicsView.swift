//
//  CharacteristicsView.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 9/1/25.
//

import SwiftUI
import CoreBluetooth

struct CharacteristicsView: View {
    var service: CBService
    
    let knownServices: [CBUUID: String] = [
        CBUUID.fromLocalizedKey("gpio_control_service"): "GPIO Control Service"
    ]
    
    let knownCharacteristics: [CBUUID: String] = [
        CBUUID.fromLocalizedKey("toggle_gpio_pin"): "Toggle GPIO Pin"
    ]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Service Info")) {
                    Text(knownServices[service.uuid] ?? "\(service.uuid)")
                }

                if let characteristics = service.characteristics {
                    Section(header: Text("Characteristics")) {
                        ForEach(characteristics, id: \.self) { characteristic in
                            Text(knownCharacteristics[characteristic.uuid] ?? "\(characteristic.uuid)")
                        }
                    }
                } else {
                    Text("No characteristics found.")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Service")
        }
    }
}
