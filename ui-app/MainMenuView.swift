
import SwiftUI

struct MainMenuView: View {
    @State private var selectedView = "Text"

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Basic", destination: BasicListView())
            }
            .navigationBarTitle("SwiftUI Features")
        }
    }
}

struct BasicListView: View{
    var body: some View {
        List {
            NavigationLink("Text", destination: TextViewDemo())
            NavigationLink("Button", destination: ButtonViewDemo())
            NavigationLink("Button Flash", destination: ButtonViewFlash())
            NavigationLink("VStack", destination: VStackViewDemo())
            NavigationLink("HStack", destination: HStackViewDemo())
            NavigationLink("ZStack", destination: ZStackViewDemo())
            NavigationLink("State Wrapper", destination: StateViewDemo())
            NavigationLink("Binding Wrapper", destination: BindingViewDemo())
            // Add more links to other feature demonstrations
        }
        .navigationBarTitle("Basic Features")
    }
}

struct TextViewDemo: View {
    var body: some View {
        Text("Welcome to SwiftUI!")
            .font(.title)                       // Sets the font of the text
            .fontWeight(.bold)                  // Makes the text bold
            .foregroundColor(.blue)             // Sets the text color to blue
            .multilineTextAlignment(.center)    // Aligns the text to the center across multiple lines
            .lineLimit(2)                       // Limits the text to a maximum of 2 lines
            .truncationMode(.tail)              // If the text is too long, it will truncate at the end
            .padding()                          // Adds padding around the text
            .border(Color.green, width: 2)      // Adds a green border with a width of 2 points
            .background(Color.yellow)           // Sets the background color to yellow
            .cornerRadius(10)                   // Rounds the corners of the background
            .shadow(color: .gray, radius: 2, x: 0, y: 2)  // Adds a shadow with specific properties
    }
}

struct ButtonViewDemo: View {
    var body: some View {
        Text("Click Me")
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct ButtonViewFlash: View {
    @State private var showMessage = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                showMessage.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showMessage = false
                }
            }
        }) {
            Text("Click Me")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        
        if showMessage {
                        Text("You've clicked the button!")
                            .font(.headline)
                            .transition(.opacity)
                    }

    }

}

struct VStackViewDemo: View {
    var body: some View {
        VStack {
            Text("Sample Text 1")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Look at the globe above.")
        }
    }
}

struct HStackViewDemo: View {
    var body: some View {
        HStack {
            Text("Sample Text 1")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Look at the globe to the left.")
        }
    }
}

// custom button
struct ZStackViewDemo: View {
    @State private var isButtonPressed = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 60)
                .cornerRadius(30)
                .shadow(radius: 10)
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                Text("Like")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            isButtonPressed.toggle()
        }
        
        if isButtonPressed {
            Text("You clicked Like!")
                .transition(.scale)
        }
    }
}


// state wrapper
struct StateViewDemo: View {
    @State private var isOn = false

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Switch State: \(isOn ? "On" : "Off")")
        }
    }
}


// binding wrapper
struct ChildView: View {
    @Binding var userName: String

    var body: some View {
        TextField("Enter your name", text: $userName)
    }
}

struct BindingViewDemo: View {
    @State var userName: String = ""
    var body: some View {
        VStack {
            Text("Username: \(userName)")
            ChildView(userName: $userName)
        }
    }
}
