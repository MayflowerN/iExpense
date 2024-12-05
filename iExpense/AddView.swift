//
//  AddView.swift
//  iExpense
//
//  Created by Ellie on 9/12/24.
//

import SwiftUI
import SwiftData
import TipKit

struct AddView: View {
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var appTips = AppTips()

    static let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {
                //*
                TipView(appTips, arrowEdge: .bottom)
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .task {
                            //* Configure and load your tips at app launch.
                            do {
                                try Tips.configure()
                            }
                            catch {
                                // Handle TipKit errors
                                print("Error initializing TipKit \(error.localizedDescription)")
                            }
                        }
            .navigationTitle($name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        modelContext.insert(item)
                        try? modelContext.save()
                        dismiss()
                    }
                }
                        ToolbarItem(placement: . cancellationAction) {
                            Button("Cancel") {
                                dismiss()
                            }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        
    }
}
    extension View {
        func style(for item: ExpenseItem) -> some View {
            if item.amount < 10 {
                return self.font(.body)
            }
            else if item.amount < 100 {
                return self.font(.title3)
            }
            else {
                return self.font(.title)
            
        }
    }
}

#Preview {
    AddView()
        .modelContainer(for: ExpenseItem.self)
}
