import SwiftUI
import FirebaseCore


@main
struct ToDoListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ToDoListView()
        }
    }
}



