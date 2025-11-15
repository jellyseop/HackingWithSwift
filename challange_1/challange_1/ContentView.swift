//
//  ContentView.swift
//  challange_1
//
//  Created by junseopLee on 11/14/25.
//

import SwiftUI

struct ContentView: View {
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards]
    
    @State private var inputUnit: UnitLength = .meters
    @State private var outputUnit: UnitLength = .kilometers
    
    @State private var number = 0.0
    
    var converted: Double {
        let input = Measurement(value: number, unit: inputUnit)
    
        return input.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                }
                
                Section("Enter a number to convert"){
                    TextField("Amount", value: $number, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("Converted result"){
                    Text(converted, format: .number)
                        
                }
            }
            .navigationTitle("Challenge #1")
        }
    }
}


#Preview {
    ContentView()
}
