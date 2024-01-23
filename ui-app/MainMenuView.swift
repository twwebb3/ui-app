
import SwiftUI
import Combine // for @EnvironmentObject wrapper demo

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
            NavigationLink("EnvironmentObject Wrapper", destination: EnvironmentObjectDemo())
            NavigationLink("Text Input", destination: TextFieldDemo())
            NavigationLink("Slider Input", destination: SliderViewDemo())
            NavigationLink("Toggle Input", destination: ToggleViewDemo())
            NavigationLink("UserData", destination: UserDefaultsDemoView())
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


// environmentObject wrapper
class UserSettings: ObservableObject {
    @Published var username: String = "Guest"
}

struct EnvironmentObjectDemo: View {
    var body: some View {
        VStack {
            HomeView()
            SettingsView()
        }
        .environmentObject(UserSettings())
    }
}

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        TextField("Username", text: $userSettings.username)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        Text("Hello, \(userSettings.username)!")
    }
}


// TextField
struct TextFieldDemo: View {
    @State var someText: String = "Some text!"
    
    var body: some View {
        VStack {
            TextField("Enter some text:", text: $someText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Here's the text you entered: \(someText)")
        }
        .padding()
    }
}

// slider input
struct SliderViewDemo: View {
    @State private var sliderValue: Double = 50 // Initial value

    var body: some View {
        VStack {
            // Slider
            Slider(value: $sliderValue, in: 0...100) // Range from 0 to 100
                .padding()

            // Text displaying the current value
            Text("Current Value: \(sliderValue, specifier: "%.1f")") // Formatted to 1 decimal place
        }
        .padding()
    }
}


// toggle button
struct ToggleViewDemo: View {
    @State private var isToggleOn: Bool = false

    var body: some View {
        VStack {
            Toggle(isOn: $isToggleOn) {
                Text("Toggle Switch")
            }
            .padding()

            Text(isToggleOn ? "Toggle is ON" : "Toggle is OFF")
                .fontWeight(isToggleOn ? .bold : .regular)
                .foregroundColor(isToggleOn ? .green : .red)
        }
        .padding()
    }
}

struct UserDefaultsDemoView: View {
    @State private var inputText: String = ""
    @State private var savedText: String = ""

    var body: some View {
        VStack {
            TextField("Enter text here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save to UserDefaults") {
                UserDefaults.standard.set(inputText, forKey: "SavedText")
                savedText = inputText
            }
            .padding()

            Text("Saved Text: \(savedText)")
                .padding()
        }
        .onAppear {
            savedText = UserDefaults.standard.string(forKey: "SavedText") ?? ""
        }
    }
}
