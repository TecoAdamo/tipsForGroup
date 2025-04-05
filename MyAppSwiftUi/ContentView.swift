//
//  ContentView.swift
//  MyAppSwiftUi
//
//  Created by Mateus on 02/04/25.
//

import SwiftUI

struct ContentView: View {
    @State  private var checkAmountText = ""
    @State private  var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocus: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totaoPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandeTotal = checkAmount + tipValue
        let amountPerPerson = grandeTotal / peopleCount
        return amountPerPerson
    }
    
    
    var checkAmount: Double {
        Double(checkAmountText.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    //Textfield (input) value for numbers, and text for strings
                    TextField("Informe o valor: ", text: $checkAmountText)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    Picker("Total de pessoas na mesa: ", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) Pessoas")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section{
                    
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Porcentagem: ")
                }
                Section{
                    Text(totaoPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                } header: {
                    Text("Total por pessoa:")
                }
            }
            .navigationTitle("MonTips")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Concluído"){
                        amountIsFocus = false
                    }
                }
            }
        }
    }
    
    
    
}
#Preview {
    ContentView()
}
