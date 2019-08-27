import XCTest
@testable import IntroductionToUnitTesting

class WeatherUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadWeather() {
        // Arrange
        let weatherData = WeatherFetchingService.getTestWeatherJSONData()
        
        // Act
        var allWeathers = [Weather]()
        
        do {
            allWeathers = try Weather.getAllWeathers(from: weatherData)
        } catch {
            print(error)
        }
        
        // Assert
        XCTAssertTrue(allWeathers.count == 3, "Was expecting 3 weather structs, but received \(allWeathers.count)")
    }
    
    func testGetFarenheitTemperature() {
        // Arrange
        let testWeather = Weather(name: "TestWeather",
                                  mainInformation: MainWeatherInformation(temperatureInKelvin: 300),
                                  windInformation: WindInformation(speed: 0.0, deg: 0),
                                  weatherDescriptions: [])
        // Act
        let expectedFarenheitTemp = Double(round(100 * 80.33) / 100)
        let actualFarenheitTemp = Double(round(100 * testWeather.farenheitTemperature) / 100)
        
        // Assert
        XCTAssertEqual(expectedFarenheitTemp, actualFarenheitTemp, "Error: expected \(expectedFarenheitTemp), but received \(actualFarenheitTemp)")
    }    
}
