import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  
   override func applicationDidFinishLaunching(_ notification: Notification) {
        let window = NSApplication.shared.windows.first
        window?.minSize = NSSize(width: 1600, height: 900) // Minimum size
        super.applicationDidFinishLaunching(notification)
    }
}
