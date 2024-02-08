

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

struct AlertTextFieldDemo: View {
    @State private var textInput: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            TextField("Type here", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                if textInput.lowercased() == "alert" {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert Triggered"),
                    message: Text("You typed 'alert' and submitted."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
}

struct AlertTextFieldDemo_Previews: PreviewProvider {
    static var previews: some View {
        AlertTextFieldDemo()
    }
}


struct SheetViewDemo: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Detail View") {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
            DetailView()
        }
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Details Header")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // Bullet points
            VStack(alignment: .leading, spacing: 5) {
                ForEach(bulletPoints, id: \.self) { point in
                    HStack {
                        Text("•")
                            .fontWeight(.bold)
                        Text(point)
                    }
                }
            }
            .padding()
            
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
    
    private var bulletPoints = [
            "First point",
            "Second point",
            "Third point",
            "Fourth point"
        ]
}

