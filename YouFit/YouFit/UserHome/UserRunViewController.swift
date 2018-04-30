//
//  UserRunViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UserRunViewController: UIViewController {
    
    
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var totalCalories:Double = 0.0
    
    private var run: Run?
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var stopButton: CustomButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isHidden = true
        startButton.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerMile)
        
        distanceLabel.text = "\(formattedDistance)"
        timerLabel.text = "\(formattedTime)"
        paceLabel.text = "Pace:  \(formattedPace)"
    }
    
    
    @IBAction func startButtonAction(_ sender: CustomButton) {
        
        stopButton.isHidden = false
        startButton.isHidden = true
        self.startRun()
        
    }
    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    
    
    
    
    
    
    @IBAction func stopButton(_ sender: CustomButton) {
        let alertController = UIAlertController(title:"" ,message: "Do you wish to end your run?",preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopRun()
            self.saveRun()
            self.performSegue(withIdentifier: "details", sender: nil)
        })
       
        
        present(alertController, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "details":
            guard let detailVC = segue.destination as? detailsofRunViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            detailVC.calorie = totalCalories
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        
    }
    }
    
    
    
    
    private func startRun() {
        
        startButton.isHidden = true
        stopButton.isHidden = false
        mapView.removeOverlays(mapView.overlays)
 
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
 
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
    }
    
    private func stopRun() {
        
        startButton.isHidden = false
        stopButton.isHidden = true
 
        locationManager.stopUpdatingLocation()
    }
    
    private func saveRun() {
        
        
        
        let newRun = Run(context: context)
        newRun.distance = distance.value
        newRun.duration = Int16(seconds)
        newRun.timestamp = Date()
        let  CaloriesPerHour: Double = 450
        
        let hours: Double = Double(seconds)/3600.0
        
        totalCalories = CaloriesPerHour*hours
        
//
        for location in locationList {
            let locationObject = Location(context: context)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRun.locations = locationObject
        }
        
        
        
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                    for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                        let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                        if(comp.rawValue == 0){
                            
                            calCount.burntCalorie = Int16(Int(calCount.burntCalorie) + Int(totalCalories))
                            
                        }
                        break
                    }
                }
                break
                
            }
        }
        catch{
            
        }
        
    
    }
    
    
    @IBAction func save(_ sender: CustomButton) {
        
        
        if (totalCalories == 0.0){
            let vc = makeUIAlertController(Message: "Please Start the Run Before saving!")
            present(vc, animated: false, completion: nil)
            
        }
        else{
        self.stopRun()
        self.saveRun()
        }
        
        
    }
 
}

extension UserRunViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.add(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 0, 0)
                mapView.setRegion(region, animated: true)
            }
            
            locationList.append(newLocation)
        }
    }
}

extension UserRunViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 10
        return renderer
    }
}
 
