import SwiftUI
import lagom

@available(macOS 13.6, *)
struct ContentView: View {
  private var impl: lagom.WebViewBridge {
    lagom.WebViewBridge.create()
  }

  @State private var backingStore: Image?

  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        LazyVStack {
          Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
          Text("Hello, world!")
          backingStore?
            .resizable()
            .scaledToFit()
        }.padding()
      }.onChange(of: geometry.size, perform: updateViewportRect)
    }
  }

  private func updateViewportRect(size: CGSize) {
    print("scroll view size: \(size)")
    let addr = Unmanaged.passUnretained(impl).toOpaque()  // unsafeAddress(:of) removed in swift#3644 :/
    print("impl is at \(addr)")
  }
}

@available(macOS 13.6, *)
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
