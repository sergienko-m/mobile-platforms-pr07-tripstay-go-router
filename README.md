# Практична робота 7 — Варіант 5

## TripStay: бронювання житла

Flutter-застосунок для пошуку готелів, обраного та бронювання поїздок. Дані тестові й зберігаються в пам’яті. Навігація побудована тільки через `go_router` 17.x.

## Запуск і перевірка

```bash
flutter pub get
flutter run
flutter analyze
flutter test
```

Потрібні Flutter 3.x та Dart 3.x.

## Карта маршрутів

| Шлях | Екран | Захист |
|---|---|---|
| `/hotels?city=Київ&nights=3` | Пошук | — |
| `/hotels/:hotelId` | Деталі готелю | — |
| `/hotels/:hotelId/rooms/:roomId?nights=3` | Номер | — |
| `/hotels/:hotelId/book?nights=3` | Форма бронювання | потрібен вхід |
| `/hotels/:hotelId/book/guests` | Вибір гостей | потрібен вхід через батьківський маршрут |
| `/trips` | Поїздки: Майбутні / Минулі | — |
| `/favorites` | Обране | — |
| `/login?from=...` | Вхід | — |
| невідома адреса | `ErrorScreen` через `errorBuilder` | — |

Три нижні вкладки реалізовані через `StatefulShellRoute.indexedStack`: `/hotels`, `/trips`, `/favorites`. Після перемикання вкладок стек і стан кожної вкладки зберігаються.

## Що реалізовано

- Пошук за містом і кількістю ночей (`city`, `nights` — query-параметри).
- Деталі готелю з параметром шляху `:hotelId`.
- Захищений маршрут бронювання через `redirect`.
- `refreshListenable: AppState`: після входу guard автоматично перевіряється знову.
- Повернення на повну початкову адресу після входу через параметр `from`, включно з query-параметрами.
- Вибір кількості гостей через `context.push<int>()` і `context.pop(value)`.
- `PopScope` на формі бронювання: вихід із незбереженими змінами потребує підтвердження.
- `DefaultTabController` для вкладок «Майбутні / Минулі».
- Обране та поїздки зберігаються в `AppState` під час навігації.
- Deep link `trip://app/hotels/<id>?nights=3` налаштований в AndroidManifest.xml та Info.plist.

## Демонстрація guard

1. Відкрити готель.
2. Натиснути «Забронювати» без входу.
3. Застосунок відкриє `/login?from=...`.
4. Натиснути «Увійти».
5. Застосунок поверне користувача на ту саму сторінку бронювання зі збереженим `nights`.

## Deep link

Android Emulator:

```bash
adb shell am start -a android.intent.action.VIEW -d "trip://app/hotels/kyiv-center?nights=3" com.example.trip_booking_app
```

iOS Simulator:

```bash
xcrun simctl openurl booted "trip://app/hotels/kyiv-center?nights=3"
```

Після відкриття deep link показується готель `Dnipro Riverside` і параметр `3 ночі`. Кнопка «Назад» повертає до каталогу, якщо deep link відкрито зі запущеного застосунку.

## Труднощі та рішення

- **Збереження вкладок.** Звичайний `ShellRoute` міг би перемонтовувати вкладки, тому використано `StatefulShellRoute.indexedStack` з окремою гілкою для кожної вкладки.
- **Повернення після входу.** Адреса з query-параметрами кодується в `from`, щоб guard не втрачав місто й кількість ночей.
- **Вибір гостей.** Екран вибору повертає `int` через `context.pop(value)`, а форма перевіряє `mounted` після `await`.
- **Незбережені зміни.** `PopScope` блокує вихід і показує діалог підтвердження.
- **Невідомі адреси.** `errorBuilder` показує зрозумілий екран із поверненням на `/hotels`.

## Структура

- `lib/router.dart` — дерево маршрутів, guard, shell і `errorBuilder`.
- `lib/app_state.dart` — `ChangeNotifier` для auth, обраного та поїздок.
- `lib/models/hotel.dart` — модель і тестові готелі.
- `lib/screens/` — екрани застосунку.
- `android/app/src/main/AndroidManifest.xml` — Android deep link.
- `ios/Runner/Info.plist` — iOS URL scheme.
- `docs/` — матеріали демонстрації.
- `test/` — автоматичні тести стану застосунку.
