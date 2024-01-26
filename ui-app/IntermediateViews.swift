

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
