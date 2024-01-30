

import SwiftUI

struct StaticListViewDemo: View {
    var body: some View {
        List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
    }
}

struct DynamicListViewDemo: View {
    let items = ["Apple", "Banana", "Orange"]

    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}

// list with sections
struct Fruit: Identifiable {
    var id = UUID()
    var name: String
}

struct FruitRowView: View {
    var fruit: Fruit

    var body: some View {
        Text(fruit.name)
            .padding()
    }
}

struct CustomRowListViewDemo: View {
    let fruits = [Fruit(name: "Apple"), Fruit(name: "Banana"), Fruit(name: "Orange")]

    var body: some View {
        List(fruits) { fruit in
            FruitRowView(fruit: fruit)
        }
    }
}

struct SectionedListViewDemo: View {
    var body: some View {
        List {
            Section(header: Text("Fruits")) {
                Text("Apple")
                Text("Banana")
            }

            Section(header: Text("Vegetables")) {
                Text("Carrot")
                Text("Tomato")
            }
        }
    }
}


struct BasicFormViewDemo: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showLoginMessage = false

    var body: some View {
        Form {
            Section(header: Text("Login Information")) {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }

            Button("Submit") {
                showLoginMessage = true
                // Hide the message after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showLoginMessage = false
                }
            }

            if showLoginMessage {
                Text("You've attempted to login!")
            }
        }
    }
}
