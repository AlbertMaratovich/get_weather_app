# CLAUDE.md

## О проекте

Это **учебный проект**. Продакшн-версии нет и не будет: приложение не публикуется в App Store, у него нет реальных пользователей, релизов и поддержки.

Цель проекта — обучение QA-инженера:
- пониманию кода iOS-приложения (Swift, UIKit, сторибоарды, сетевой слой, ViewModel);
- написанию и поддержке автотестов: unit-тестов (XCTest) и UI-тестов (XCUITest);
- работе с моками, тестовыми данными и тест-планами Xcode.

Само приложение простое: логин → ввод города (или геолокация) → прогноз температуры на утро/день/вечер/ночь через бесплатный API Open-Meteo.

## Как работать в этом репозитории

- **Главное — учебная ценность и понятность.** Объясняй изменения так, чтобы их понял тестировщик без глубокого опыта в iOS-разработке: что делает код, почему именно так, как это связано с тестами.
- Не нужно думать о продакшн-аспектах: релизах, обратной совместимости, безопасности хранения данных, аналитике, локализации, производительности. Не предлагай такие доработки, если об этом не просят.
- Захардкоженные логин и пароль (`user` / `123456` в `LoginViewModel`) — намеренное упрощение, это не баг.
- Не усложняй архитектуру без запроса: никаких DI-фреймворков, координаторов и т.п. Код должен оставаться читаемым для новичка.
- Комментарии в коде, сообщения в `XCTAssert*` и `XCTFail` пишем **на русском** — так принято в проекте.
- При изменении кода приложения проверяй, не ломаются ли тесты, и подсказывай, какие тесты стоит добавить или обновить.

## Стек

- Swift 5, UIKit, Storyboard (`Resources/Base.lproj/Main.storyboard`)
- async/await
- Alamofire 5 (через Swift Package Manager)
- Open-Meteo API: геокодинг (`geocoding-api.open-meteo.com`) и прогноз (`api.open-meteo.com`), ключ не нужен

## Структура

Корень git-репозитория — эта папка, Xcode-проект лежит в `get_weather_app/`.

```
get_weather_app/
├── Application/            AppDelegate, SceneDelegate
├── Screens/                экраны: ViewController + ViewModel
│   ├── LoginScreen/
│   ├── CitySelectionScreen/
│   └── WeatherDetails/
├── Services/               NetworkService (запросы к API), LocationService + протокол
├── Models/                 Codable-модели ответов API
├── Extensions/             XCUIElement+Extension: safeTap(), clearText() для UI-тестов
├── Resources/              сторибоарды, ассеты
├── TestPlans/              RegressionTests, SmokeTests, UnitTests (.xctestplan)
├── get_weather_appTests/   unit-тесты
└── get_weather_appUITests/ UI-тесты
```

## Правила

- Не делай изменений если тебя не просили напрямую
- Старайся объяснять простым языком
- Если не просили прямого решения - не показывай его, цель - обучение, поэтому важно чтобы пользователь доходил своей головой до решения задачи


### Запуск

Из папки `get_weather_app/` (подставь любой доступный симулятор):

```bash
xcodebuild test -project get_weather_app.xcodeproj -scheme get_weather_app -testPlan UnitTests -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```
