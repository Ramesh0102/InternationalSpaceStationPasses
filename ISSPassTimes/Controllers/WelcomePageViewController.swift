//
//  WelcomePageViewController.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/11/18.
//  Copyright © 2018 valador. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomePageViewController: UIViewController  {

    private var clLocationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        clLocationManager = CLLocationManager()
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getLocation(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                showSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                clLocationManager.requestLocation()
            }
        } else {
            showSettings()
        }
    }
    
    func showSettings() {
        let alertController = UIAlertController (title: "Enable locations services", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passesTimes" {
            if let destVC = segue.destination as? PassTimesTableViewController,
                let usrLocation = currentLocation {
                destVC.currentLocation = usrLocation
            }
        }
    }
}
extension WelcomePageViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        currentLocation = location
        self.performSegue(withIdentifier: "passesTimes", sender: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(message: "Failed to initialize capturing Location")
    }
    func showAlert(message:String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Warning!", comment: "Warning title"), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK title"), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
