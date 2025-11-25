//
//  ContentView.swift
//  TempConvert
//
//  Created by kevin dao on 11/12/25.
//

import SwiftUI

enum TempUnit: String, CaseIterable, Identifiable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var id: String { rawValue }
    
    var unit: UnitTemperature {
        switch self {
            case .celsius: return .celsius
            case .fahrenheit: return .fahrenheit
            case .kelvin: return .kelvin
        }
    }
}

struct ContentView: View {
    @State private var inputUnit: TempUnit = .celsius
    @State private var outputUnit: TempUnit = .fahrenheit
    @State private var inputValue: Double?
    
    @FocusState private var isInputFocused: Bool
    
    var output: String {
        guard let inputValue else { return "-" }
        let inputAsMeasurement = Measurement(value: inputValue, unit: inputUnit.unit)
        return inputAsMeasurement.converted(to: outputUnit.unit).value.formatted()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select your units") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(TempUnit.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }

                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(TempUnit.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                }
                
                Section("Input") {
                    TextField("Enter a value to convert", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }
                
                Section("Output") {
                    Text(output)
                }
            }
            .navigationTitle("TempConvert")
            .toolbar {
                if isInputFocused {
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
