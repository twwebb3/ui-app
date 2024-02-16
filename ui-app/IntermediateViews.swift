

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


struct ModalDemo: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("This is a modal view")
                .font(.title)
            
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green.edgesIgnoringSafeArea(.all))
    }
}

struct ModalViewDemo: View {
    @State private var showModal = false

    var body: some View {
        Button("Show Modal") {
            showModal = true
        }
        .sheet(isPresented: $showModal) {
            ModalDemo()
        }
    }
}

struct AnimationViewDemo: View {
    // State to hold the offset for animation
    @State private var moveCircle: Bool = false

    var body: some View {
        VStack {
            // Circle that will move
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .offset(x: moveCircle ? 100 : -100, y: 0) // Start from -100 to move to 100
                .animation(.easeInOut(duration: 2), value: moveCircle) // Animate the offset change
                
            // Button to trigger the animation
            Button("Move Circle") {
                moveCircle.toggle() // Toggle the state to move the circle back and forth
            }
            .padding(.top, 20)
        }
    }
}

struct AnimationIntermediateViewDemo: View {
    @State private var scale: CGFloat = 1
    @State private var angle: Double = 0
    @State private var opacity: Double = 1
    @State private var color: Color = .blue
    
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .foregroundColor(color)
                .frame(width: 100 * scale, height: 100 * scale)
                .rotationEffect(.degrees(angle))
                .opacity(opacity)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        scale = 2
                        color = .red
                    }
                    
                    withAnimation(.linear(duration: 2)) {
                        angle += 360
                    }
                    
                    withAnimation(.easeInOut(duration: 1).delay(1)) {
                        opacity = 0
                    }
                    
                    // Reset after animations complete
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut) {
                            scale = 1
                            angle = 0
                            opacity = 1
                            color = .blue
                        }
                    }
                }
            
            Spacer()
            
            Text("Tap the Circle")
                .font(.headline)
        }
    }
}


// back appears mirrored, why?
struct FlipCardViewDemo: View {
    @State private var isFlipped = false
    @State private var degrees = 0.0

    var body: some View {
        VStack {
            Spacer()
            // 3D Flip Animation Container
            ZStack {
                // Front Side
                CardView(content: "Front", color: .blue)
                    .opacity(isFlipped ? 0 : 1) // Hide when flipped
                
                // Back Side
                CardView(content: "Back", color: .green)
                    .opacity(isFlipped ? 1 : 0) // Show when flipped
            }
            .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0)) // 3D rotation effect
            .onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    degrees += 180
                }
                withAnimation(.linear(duration: 0.001).delay(0.25)) {
                    // This toggles the visibility halfway through the flip to make the flip look realistic.
                    isFlipped.toggle()
                }
            }
            Spacer()
        }
    }
}

struct CardView: View {
    let content: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(color)
            .frame(width: 200, height: 300)
            .overlay(
                Text(content)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
            .shadow(radius: 5)
    }
}
