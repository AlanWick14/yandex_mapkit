import Foundation
import YandexMapsMobile

class YandexMapKitInitializer {
    private static var isInitialized = false
    private static let lock = NSLock()
    
    static func initialize() {
        lock.lock()
        defer { lock.unlock() }
        
        guard !isInitialized else {
            return
        }
        
        // Force initialization by accessing the shared instance
        _ = YMKMapKit.sharedInstance()
        isInitialized = true
        
        print("✅ YandexMapKit initialized successfully")
    }
}