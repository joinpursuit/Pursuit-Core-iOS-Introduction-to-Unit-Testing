import UIKit

class WeatherViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var weatherTableView: UITableView!
    
    // MARK: - Private properties
    
    private var allWeather = [Weather]() {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadAllWeather()
    }
    
    // MARK: - Private methods
    
    private func configureTableView() {
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }
    
    private func loadAllWeather() {
        do {
            allWeather = try WeatherFetchingService.getAllWeather()
        } catch {
            let alertVC = UIAlertController(title: "Error", message: "Unable to get weather: \(error)", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
}

extension WeatherViewController: UITableViewDelegate {}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWeather.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        let weather = allWeather[indexPath.row]
        cell.textLabel?.text = weather.name
        let displayTemp = String(format: "%.f", weather.farenheitTemperature)
        cell.detailTextLabel?.text = "Current temperature: \(displayTemp)ºF"
        return cell
    }
}
