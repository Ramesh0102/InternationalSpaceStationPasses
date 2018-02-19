//
//  PassTimesTableViewController.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/9/18.
//  Copyright © 2018 valador. All rights reserved.
//

import UIKit
import CoreLocation

class PassTimesTableViewController: UITableViewController {
    
    var currentLocation: CLLocation?
    var recivedResponse: WebResponse?
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.registerCells()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getPassesInfo()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resp = recivedResponse {
            return resp.response.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PassTimesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PassTimesTableViewCell", for: indexPath) as! PassTimesTableViewCell
        
        if let resp = recivedResponse {
            let item = resp.response[indexPath.row]
            cell.serialNo.text = "\(indexPath.row+1)"
            cell.passTime.text = "Date : " + UtilityClass.getTimeStamp(for: item.risetime)
            cell.duration.text = "Duration : " + UtilityClass.secondsToHoursMinutesSeconds(seconds: item.duration)
        }
        
        return cell
    }
    
    func registerCells() {
        let PassTimesTableViewCell = UINib(nibName:"PassTimesTableViewCell" , bundle: nil)
        self.tableView.register(PassTimesTableViewCell, forCellReuseIdentifier: "PassTimesTableViewCell")
    }
    
    func getPassesInfo() {
        if let usrLocation = currentLocation {
            APIManager.fetchISSPassesInfo(latitude: usrLocation.coordinate.latitude, longitude: usrLocation.coordinate.longitude, onComplete: { (response, error) in
                DispatchQueue.main.async {
                    
                    if let data = response {
                        self.recivedResponse = data
                        self.tableView.reloadData()
                        self.indicator.stopAnimating()
                    } else {
                        self.indicator.stopAnimating()
                        if error != nil{
                            self.showAlert(message: (error?.localizedDescription)!)
                        }else{
                            self.showAlert(message: "Failed to fetch States details. Go back and try again")
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        getPassesInfo()
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func showAlert(message:String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Warning!", comment: "Warning title"), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK title"), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
