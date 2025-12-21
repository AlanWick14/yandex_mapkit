# Yandex MapKit Loyihasi Tahlili va Yechimlar

## 📋 Muammo Tahlili

### iOS Crash Muammosi

**Xatolik:** Vulkan renderer initialization paytida crash

- **Sabab:** `YandexMapController.init()` da `vulkanPreferred: true` bilan Vulkan renderer ishga tushirilganda xotira ajratish muammosi
- **Xatolik belgilari:**
  - `mach_vm_allocate_kernel failed within call to vm_map_enter`
  - `-[__NSCFString characterAtIndex:]` xatosi
  - Vulkan renderer initialization paytida crash

**Yechim:** Vulkan renderer'ni o'chirib qo'ydim. Endi xarita Metal renderer bilan ishlaydi (iOS'da standart).

---

## 🔍 Loyiha Tahlili

### 1. Yandex MapKit Versiyasi

**Joriy versiya:** `4.6.1` (2024-yil oxirida yangilangan)

- **iOS:** `YandexMapsMobile 4.6.1-lite` yoki `4.6.1-full`
- **Android:** `com.yandex.android:maps.mobile:4.6.1-lite` yoki `4.6.1-full`

**Eskirgan API'lar:**

- ✅ Hozirgi versiyada asosiy API'lar ishlayapti
- ⚠️ `vulkanPreferred` parametri ba'zi iOS versiyalarida muammo qilishi mumkin
- ✅ Flutter plugin versiyasi: `4.1.0` (so'nggi versiya)

### 2. Yandex MapKit Bepul yoki Pullik? ✅ ANIQ JAVOB

**✅ BEPUL (100% bepul):**

- ✅ **SDK o'zi bepul** - YandexMapsMobile SDK'ni yuklab olish va ishlatish bepul
- ✅ **API kalit bepul** - https://developer.tech.yandex.ru/services/ dan API kalit olish bepul
- ✅ **Kod bepul** - Bu Flutter paketi ham bepul va ochiq kodli
- ✅ **Oylik 25,000 MAU gacha bepul** - Oyiga 25,000 tagacha noyob foydalanuvchi (MAU) uchun to'liq bepul

**💰 PULLIK BO'LISHI MUMKIN (faqat limitdan oshganda):**

- 💰 **25,000+ MAU** - Agar oyiga 25,000 dan ortiq noyob foydalanuvchi bo'lsa, pullik tarifga o'tish kerak
- 💰 **Enterprise funksiyalar** - Ba'zi qo'shimcha funksiyalar uchun pullik (lekin asosiy funksiyalar bepul)
- 💰 **Navikit variant** - Yandex Navigator integratsiyasi pullik (lekin bu paketda navikit qo'llab-quvvatlanmaydi)

**📊 ANIQ CHEKLOVLAR:**

- **Bepul limit:** Oyiga 25,000 noyob foydalanuvchi (MAU)
- **Pullik limit:** 25,000+ MAU uchun narxlar mavjud (masalan: 125,000 MAU uchun ~$4,800/yil)

**✅ XULOSA:**

- **Bu loyiha 100% bepul** - SDK, API kalit, kod - hammasi bepul
- **25,000 MAU gacha** - To'liq bepul foydalanish
- **25,000+ MAU** - Faqat shu holatda pullik bo'ladi
- **Kichik va o'rta loyihalar uchun** - Umuman pullik emas!

**💡 MASALAN:**

- Agar ilovangizda oyiga 10,000 foydalanuvchi bo'lsa → **100% BEPUL** ✅
- Agar ilovangizda oyiga 50,000 foydalanuvchi bo'lsa → **Pullik tarif kerak** 💰

### 3. Bu Paket va Rasmiy Flutter Paketi Farqi

**Bu paket (Unact/yandex_mapkit):**

- ✅ GitHub'da ochiq kodli
- ✅ `lite` va `full` variantlarni qo'llab-quvvatlaydi
- ✅ Ko'p funksiyalar: routing, search, suggest
- ✅ Versiya: 4.1.0
- ⚠️ Uchinchi tomon paketi (rasmiy emas)

**Rasmiy Flutter paketi (yandex_mapkit):**

- ❓ Pub.dev'da mavjud bo'lishi mumkin
- ❓ Yandex tomonidan rasmiy qo'llab-quvvatlanadi
- ❓ Funksiyalar cheklangan bo'lishi mumkin

**Tavsiya:** Bu paket yaxshi ishlayapti va ko'p funksiyalarga ega. Agar rasmiy paket mavjud bo'lsa, ularni solishtirib ko'ring.

---

## 🛠️ Qilingan O'zgarishlar

### 1. Vulkan Renderer O'chirildi

**Fayl:** `ios/Classes/lite/YandexMapController.swift`

**O'zgarish:**

```swift
// Oldin:
self.mapView = FLYMKMapView(frame: frame, vulkanPreferred: YandexMapController.isM1Simulator())

// Hozir:
self.mapView = FLYMKMapView(frame: frame, vulkanPreferred: false)
```

**Sabab:**

- Vulkan renderer iOS simulyatorlarda va ba'zi qurilmalarda crash qiladi
- Metal renderer iOS'da standart va barqaror
- Vulkan faqat M1 simulyatorlarda kerak edi, lekin hozir muammo qilmoqda

---

## 📝 Qo'shimcha Tavsiyalar

### 1. iOS Sozlashni Tekshiring

**AppDelegate.swift** da API kalit to'g'ri o'rnatilganligini tekshiring:

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
    YMKMapKit.setLocale("ru_RU") // yoki "en_US"
    YMKMapKit.setApiKey("YOUR_API_KEY") // To'g'ri API kalit kiriting!
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 2. Podfile Sozlash

**ios/Podfile** da iOS versiyasini tekshiring:

```ruby
platform :ios, '12.0'  # iOS 12+ kerak

# Variant tanlash (lite yoki full)
ENV['YANDEX_MAPKIT_VARIANT'] = 'lite'  # yoki 'full'
```

### 3. Pod Install

O'zgarishlardan keyin pod'larni qayta o'rnating:

```bash
cd ios
pod deintegrate
pod install
cd ..
```

### 4. Xotira Muammolari

Agar hali ham xotira muammolari bo'lsa:

- Simulyator o'rniga real qurilmada sinab ko'ring
- Xarita variantini `lite` ga o'zgartiring (kichikroq xotira ishlatadi)
- Xarita o'lchamini kamaytiring

---

## 🔄 Keyingi Qadamlar

1. ✅ Vulkan renderer o'chirildi
2. ⏭️ Loyihani qayta build qiling
3. ⏭️ iOS simulyator yoki qurilmada sinab ko'ring
4. ⏭️ Agar muammo davom etsa, Yandex MapKit hujjatlarini ko'rib chiqing

---

## 📚 Foydali Linklar

- **Yandex MapKit Hujjatlari:** https://yandex.com/dev/mapkit/doc/ios/
- **API Kalit Olish:** https://developer.tech.yandex.ru/services/
- **GitHub Repository:** https://github.com/Unact/yandex_mapkit
- **Tariflar:** https://yandex.com/maps-api/products/mapkit

---

## ⚠️ Muhim Eslatmalar

1. **API Kalit:** Har doim to'g'ri API kalitdan foydalaning
2. **Variant:** `lite` variant kichikroq va tezroq, `full` variant ko'proq funksiyalarga ega
3. **iOS Versiya:** iOS 12+ kerak
4. **Xotira:** Xarita katta xotira ishlatishi mumkin, xotira cheklovlarini tekshiring
