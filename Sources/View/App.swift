import Foundation
import SwiftUI

@main
@available(macOS 13.6, *)
struct TestApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
