//
//  jsonMockDecoderService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 11.07.2026.
//
import XCTest

class DecoderMockService {
    func loadDataFromJSON(fileName: String) -> Data {
        // Находим бандл, в котором запущен текущий тест
        let bundle = Bundle(for: type(of: self))
        
        // проверяем содержимое бандла и выводим в консоль названия файлов
        print("📍 Ищем файлы по пути: \(bundle.resourcePath ?? "неизвестно")")
        if let resourcePath = bundle.resourcePath,
           let files = try? FileManager.default.contentsOfDirectory(atPath: resourcePath) {
            print("--- 📦 СПИСОК ВСЕХ ФАЙЛОВ В БАНДЛЕ ТЕСТОВ ---")
            for file in files {
                print("📄 \(file)")
            }
            print("-----------------------------------------")
        }
        
        // Читаем данные из файла
        do {
            if let url = bundle.url(forResource: fileName, withExtension: "json") {
                if let data = try? Data(contentsOf: url) {
                    return data
                } else {
                    print("Не удалось найти файл \(fileName).json")
                    return Data()
                }
            } else {
                print("❌ Не удалось найти файл \(fileName).json")
                return Data()
            }
        }
    }
}
