//
//  AppTips.swift
//  iExpense
//
//  Created by Ellie on 10/30/24.
//

import SwiftUI
import TipKit


// Define your tip's content.
struct AppTips: Tip {
    var title: Text {
        Text("Add your expenses")
    }


    var message: Text? {
        Text("Enter name of expenses, type, and amount")
    }


    var image: Image? {
        Image(systemName: "star")
    }
}


