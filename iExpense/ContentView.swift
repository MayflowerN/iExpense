//
//  ContentView.swift
//  iExpense
//
//  Created by Ellie on 9/11/24.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
    }


struct ExpenseList: View {
    @Query private var expenses: [ExpenseItem]
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    @Environment(\.modelContext) var modelContext

    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
            }
        }
    init(type: String = "All", sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate {
            if type == "All" {
                return true
            } else {
                return $0.type == type
            }
        }, sort: sortOrder)
        }
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: localCurrency))
                        .style(for: item)
                }
                .accessibilityElement()
                .accessibilityLabel("\(item.name) - \(item.amount)")
                .accessibilityValue(String(item.type))
                }
            
            
            }
        
            
        }
      //  .onDelete(perform: deleteItems)
    
    }

               
struct ContentView: View {
    //@State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    @Environment(\.modelContext) var modelContext
    //@Query(sort: [SortDescriptor(\ExpenseItem.amount)]) var expenseItem: [ExpenseItem]

@State private var sortOrder = [
    SortDescriptor(\ExpenseItem.name), SortDescriptor(\ExpenseItem.amount),
]
    @State private var expenseType = "All"
    var body: some View {
        NavigationStack {
            ExpenseList(type: expenseType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort By", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Name (Z-A)")
                                .tag ([
                                    SortDescriptor(\ExpenseItem.name, order: .reverse),
                                       SortDescriptor(\ExpenseItem.amount)
                                      ])
                            Text("Amount (Cheapest First)")
                                .tag ([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                            Text("Amount (Most Expensive First)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        
                    }
                }
                Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                    Picker("Filter", selection: $expenseType) {
                        Text("Show All Expenses")
                            .tag("All")
                        Divider()
                        ForEach(AddView.types, id: \.self) { type in
                            Text(type)
                                .tag(type)
                        }
                    }
                }
            }

            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
            
        }
       
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
