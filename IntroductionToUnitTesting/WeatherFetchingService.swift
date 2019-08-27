import Foundation

struct WeatherFetchingService {
    static func getAllWeather() throws -> [Weather] {
        let weatherJSONData = getTestWeatherJSONData()
        return try Weather.getAllWeathers(from: weatherJSONData)
    }
    
    static func getTestWeatherJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "testWeather", ofType: "json") else {
            fatalError("testWeather.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}
