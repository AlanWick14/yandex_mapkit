import CoreLocation
import Flutter
import UIKit
import YandexMapsMobile

public class InitLite: Init {
  private static var hasStarted = false
  private static let startLock = NSLock()
  
  public class func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(
      YandexMapFactory(registrar: registrar),
      withId: "yandex_mapkit/yandex_map"
    )
    
    // Delay onStart() to ensure MapKit is fully initialized with API key
    // This will be called when the first map view is created to prevent
    // crashes in getPlatformInstance during plugin registration
  }
  
  public class func ensureMapKitStarted() {
    startLock.lock()
    defer { startLock.unlock() }
    
    if !hasStarted {
      // Call onStart() on main thread to ensure MapKit is ready
      // This is called when the first map view is created, after API key is set
      if Thread.isMainThread {
        YMKMapKit.sharedInstance().onStart()
        hasStarted = true
      } else {
        DispatchQueue.main.sync {
          YMKMapKit.sharedInstance().onStart()
          hasStarted = true
        }
      }
    }
  }
}
