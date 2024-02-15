
import SwiftUI
import Combine // for @EnvironmentObject wrapper demo

struct MainMenuView: View {
    @State private var selectedView = "Text"

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Basic", destination: BasicListView())
                NavigationLink("Intermediate", destination: IntermediateListView())
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

struct IntermediateListView: View {
    var body: some View {
        List {
            NavigationLink("Static List", destination: StaticListViewDemo())
            NavigationLink("Dynamic List", destination: DynamicListViewDemo())
            NavigationLink("Custom Row List", destination: CustomRowListViewDemo())
            NavigationLink("Sectioned List", destination: SectionedListViewDemo())
            NavigationLink("Basic Form", destination: BasicFormViewDemo())
            NavigationLink("Simple Alert", destination: AlertTextFieldDemo())
            NavigationLink("Sheets", destination: SheetViewDemo())
            NavigationLink("Modals", destination: ModalViewDemo())
            NavigationLink("Animation (simple)", destination: AnimationViewDemo())
            NavigationLink("Animation (intermediate)", destination: AnimationIntermediateViewDemo())
        }
        .navigationBarTitle("Intermediate Features")
    }
}
