import Flutter
import UIKit
import YandexMapsMobile

public class YandexDriving: NSObject, FlutterPlugin {
  private let methodChannel: FlutterMethodChannel!
  private let pluginRegistrar: FlutterPluginRegistrar!
  // Lazy initialization to prevent crash during plugin registration
  private lazy var drivingRouter: YMKDrivingRouter = {
    InitLite.ensureMapKitStarted()
    return YMKDirectionsFactory.instance().createDrivingRouter(withType: YMKDrivingRouterType.combined)
  }()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "yandex_mapkit/yandex_driving",
      binaryMessenger: registrar.messenger()
    )

    let plugin = YandexDriving(channel: channel, registrar: registrar)

    registrar.addMethodCallDelegate(plugin, channel: channel)
  }

  public required init(channel: FlutterMethodChannel, registrar: FlutterPluginRegistrar) {
    self.pluginRegistrar = registrar
    self.methodChannel = channel
    // Don't initialize drivingRouter here - it's lazy now

    super.init()

    self.methodChannel.setMethodCallHandler(self.handle)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initSession":
      initSession(call)
      result(nil)
      break
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func initSession(_ call: FlutterMethodCall) {
    let params = call.arguments as! [String: Any]
    let id  = params["id"] as! Int

    YandexDrivingSession.initSession(id: id, registrar: pluginRegistrar, drivingRouter: drivingRouter)
  }
}
