
import SwiftUI

struct MainMenuView: View {
    @State private var selectedView = "Text"

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Text", destination: TextViewDemo())
                NavigationLink("Button", destination: ButtonViewDemo())
                NavigationLink("Button Flash", destination: ButtonViewFlash())
                // Add more links to other feature demonstrations
            }
            .navigationBarTitle("SwiftUI Features")
        }
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
