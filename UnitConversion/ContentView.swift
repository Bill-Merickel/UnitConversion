//
//  ContentView.swift
//  UnitConversion
//
//  Created by Bill Merickel on 3/22/25.
//

import SwiftUI

struct ContentView: View {
  enum Unit: String, CaseIterable, Identifiable {
    case m, km, ft, yd, mi
    var id: Self { self }
  }
  
  @State private var inputNumber: Double = 0.0
  @State private var inputUnit: Unit = .m
  @State private var outputUnit: Unit = .km
  @FocusState private var isFocused: Bool
  
  private let kmToM: Double = 1000
  private let ftToM: Double = 0.3048
  private let ydToM: Double = 0.9144
  private let miToM: Double = 1609.34
  
  private var outputNumber: Double {
    var inputAsMeters: Double = inputNumber
    
    switch inputUnit {
    case .m:
      break
    case .km:
      inputAsMeters *= kmToM
    case .ft:
      inputAsMeters *= ftToM
    case .yd:
      inputAsMeters *= ydToM
    case .mi:
      inputAsMeters *= miToM
    }
    
    switch outputUnit {
    case .m:
      return inputAsMeters
    case .km:
      return inputAsMeters / kmToM
    case .ft:
      return inputAsMeters / ftToM
    case .yd:
      return inputAsMeters / ydToM
    case .mi:
      return inputAsMeters / miToM
    }
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Enter Input") {
          TextField("Ex. 4", value: $inputNumber, format: .number)
            .keyboardType(.decimalPad)
            .focused($isFocused)
          Picker("Unit", selection: $inputUnit) {
            ForEach(Unit.allCases) { unit in
              Text(unit.rawValue)
            }
          }
          .pickerStyle(.segmented)
        }
        Section("Select Output Unit") {
          Picker("Unit", selection: $outputUnit) {
            ForEach(Unit.allCases) { unit in
              Text(unit.rawValue)
            }
          }
          .pickerStyle(.segmented)
        }
        Section("Result") {
          Text(outputNumber.formatted())
        }
      }
      .navigationTitle(Text("Unit Conversion"))
      .toolbar {
        if isFocused {
          Button("Done") {
            isFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
