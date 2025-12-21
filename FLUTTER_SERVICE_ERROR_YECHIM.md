# Flutter Service Protocol Error - Yechim

## 🔴 Xatolik

```
Error connecting to the service protocol: failed to connect to http://127.0.0.1:51802/9CoKxrniKNs=/
getVersion: (-32000) Service connection disposed
```

## 📋 Sabab

Bu xatolik app crash qilganda yuzaga keladi. Asosiy muammo **Yandex MapKit initialization**'da:

1. **API kalit to'g'ri o'rnatilmagan** - `AppDelegate.swift` da `YOUR_API_KEY` o'rniga haqiqiy API kalit bo'lishi kerak
2. **YMKMapKit initialization tartibi** - API kalit va locale o'rnatilgandan keyin plugin register qilinishi kerak
3. **Crash log'ga ko'ra:** `YMKMapKit(Factory) getPlatformInstance` da muammo

---

## ✅ YECHIM

### 1. AppDelegate.swift ni To'g'rilash

**Muammo:** `YOUR_API_KEY` o'rniga haqiqiy API kalit bo'lishi kerak

**Yechim:**

```swift
import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 1. AVVAL API kalit va locale o'rnatish (MUHIM!)
    YMKMapKit.setApiKey("HAQIQIY_API_KALIT_BU_YERGA") // YOUR_API_KEY emas!
    YMKMapKit.setLocale("ru_RU") // yoki "en_US", "uz_UZ"
    
    // 2. Keyin Flutter plugin'larni register qilish
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 2. API Kalit Olish

1. https://developer.tech.yandex.ru/services/ ga kiring
2. "MapKit Mobile SDK" xizmatini tanlang
3. API kalit yarating
4. Kalitni `AppDelegate.swift` ga qo'ying

### 3. Pod'larni Qayta O'rnatish

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### 4. Clean Build

```bash
# Flutter clean
flutter clean

# iOS clean
cd ios
xcodebuild clean
cd ..

# Qayta build
flutter pub get
flutter run
```

---

## 🔍 Qo'shimcha Tekshirishlar

### 1. API Kalit To'g'riligini Tekshirish

- ✅ API kalit bo'sh emasligi
- ✅ API kalit "YOUR_API_KEY" emasligi
- ✅ API kalit to'g'ri formatda (uzun string)

### 2. Locale To'g'riligini Tekshirish

- ✅ Locale format: `"ru_RU"`, `"en_US"`, `"uz_UZ"`
- ✅ Locale bo'sh emasligi

### 3. Initialization Tartibi

**TO'G'RI TARTIB:**
1. `YMKMapKit.setApiKey()` - birinchi
2. `YMKMapKit.setLocale()` - ikkinchi
3. `GeneratedPluginRegistrant.register()` - uchinchi

**NOTO'G'RI TARTIB:**
- Plugin'larni avval register qilish
- API kalitni keyin o'rnatish

---

## 🛠️ Debug Qadamlar

### 1. Console'da Xatolikni Ko'rish

```bash
flutter run --verbose
```

### 2. Xcode'da Run Qilish

1. Xcode'da `ios/Runner.xcworkspace` ni oching
2. Product > Run
3. Console'da xatolikni ko'ring

### 3. Crash Log'ni Tahlil Qilish

Crash log'da quyidagilarni qidiring:
- `YMKMapKit` bilan bog'liq xatoliklar
- `getPlatformInstance` xatoliklari
- API kalit bilan bog'liq xatoliklar

---

## ⚠️ MUHIM ESLATMALAR

1. **API Kalit:** Har doim haqiqiy API kalitdan foydalaning
2. **Initialization Tartibi:** API kalit va locale o'rnatilgandan keyin plugin'larni register qiling
3. **Clean Build:** Muammo bo'lsa, clean build qiling
4. **Pod Install:** O'zgarishlardan keyin pod install qiling

---

## 📞 Yordam

Agar muammo davom etsa:
1. Xcode console'da to'liq xatolikni ko'ring
2. Crash log'ni to'liq ko'rib chiqing
3. API kalit to'g'riligini tekshiring
4. Yandex Developer Portal'da API kalit holatini tekshiring


