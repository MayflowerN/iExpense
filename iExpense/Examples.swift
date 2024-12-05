//
//  Examples.swift
//  iExpense
//
//  Created by Ellie on 9/11/24.
//

//import SwiftUI
//import Observation
//
//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
//struct Examples: View {
//    @State private var user = User()
//
//       var body: some View {
//           VStack {
//               Text("Your name is \(user.firstName) \(user.lastName).")
//
//               TextField("First name", text: $user.firstName)
//               TextField("Last name", text: $user.lastName)
//           }
//       }
//   }
//#Preview {
//    Examples()
//}





//import SwiftUI
//
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name: String
//
//    var body: some View {
//        Text("Hello, \(name)!")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}
//struct FirstView: View {
//    @State private var showingSheet = false
//    var body: some View {
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "ellienween")
//        }
//    }
//}
//#Preview {
//    FirstView()
//}





//import SwiftUI
//
//
//struct NumberView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//    var body: some View {
//        NavigationStack {
//        VStack {
//            List {
//                ForEach(numbers, id: \.self) {
//                    Text("Row \($0)")
//                }
//                .onDelete(perform: removeRows)
//            }
//
//            Button("Add Number") {
//                numbers.append(currentNumber)
//                currentNumber += 1
//            }
//            .toolbar {
//                EditButton()
//            }
//            }
//        }
//    }
//}
//
//#Preview {
//    NumberView()
//}




//import SwiftUI
//
//struct UserDefault: View {
//    @AppStorage("tapCount") private var tapCount = 0
//    //@State private var tapCount = 0
//
//    var body: some View {
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//            UserDefaults.standard.set(tapCount, forKey: "Tap")
//        }
//    }
//}
//#Preview {
//    UserDefault()
//}





//import SwiftUI
//
//
//struct User: Codable {
//    let firstName: String
//    let lastName: String
//}
//struct Content: View {
//    @State private var users = User(firstName: "Taylor", lastName: "Swift")
//    var body: some View {
//        Button("Save User") {
//            let encoder = JSONEncoder()
//            
//            if let data = try? encoder.encode(users) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
//    }
//}
//#Preview {
//    Content()
//}
