import CoreLocation
import Flutter
import UIKit
import YandexMapsMobile

public class InitLite: Init {
  private static var hasStarted = false
  private static let startLock = NSLock()
  
  public class func register(with registrar: FlutterPluginRegistrar) {
    // IMPORTANT: YMKMapKit.setApiKey() MUST be called in AppDelegate
    // BEFORE GeneratedPluginRegistrant.register() is called.
    // 
    // Example AppDelegate code:
    // YMKMapKit.setApiKey("YOUR_API_KEY")
    // YMKMapKit.setLocale("ru_RU")
    // GeneratedPluginRegistrant.register(with: self)
    //
    // DO NOT call ensureMapKitStarted() here - it will crash if API key isn't set.
    // MapKit initialization is deferred until the first map view is created.
    
    registrar.register(
      YandexMapFactory(registrar: registrar),
      withId: "yandex_mapkit/yandex_map"
    )
  }
  
  public class func ensureMapKitStarted() {
    startLock.lock()
    defer { startLock.unlock() }
    
    if !hasStarted {
      // IMPORTANT: This assumes YMKMapKit.setApiKey() was called in AppDelegate
      // before GeneratedPluginRegistrant.register() is called.
      // Call onStart() on main thread to ensure MapKit is ready.
      // This is called when the first map view is created, after API key is set.
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
