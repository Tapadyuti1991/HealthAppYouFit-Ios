//
//  displayFoodViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/28/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class displayFoodViewController: UITableViewController, UISearchResultsUpdating  {

 
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredRoom = [Food]()
    var unfilteredRoom = [Food]()
    
    var totalRoom:Int = 0
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        
        self.tableView.rowHeight = 160
        
        do{
            unfilteredRoom = try context.fetch(Food.fetchRequest())
            totalRoom = unfilteredRoom.count
        }
        catch{
            print("Error in fetching from Data base")
        }
        
        filteredRoom = unfilteredRoom
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        super.viewDidLoad()
        print("View DID Load")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            print("TEMPO  COUNT BEFORE FILTERED ROMM")
            print(filteredRoom.count)
            filteredRoom = dataFood.filter({
                (eachRoom : Food) -> Bool in return (eachRoom.foodName?.lowercased().contains(searchText.lowercased()))!
                }
            )
            print("TEMPO  COUNT FILTERED ROMM")
            print(filteredRoom.count)
            
        } else {
            filteredRoom = dataFood
            print("INSIDE ELSE FILTER *****TEMPO  COUNT FILTERED ROMM")
            print(filteredRoom.count)
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRoom.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomViewCell", for: indexPath) as? FoodViewCell else {
            fatalError("The dequeued cell is not an instance of RoomTableViewCell.")
        }
        let rm = filteredRoom[indexPath.row]
        cell.foodName.text! = rm.foodName!
        cell.rating.text! = rm.rating!
        cell.calorie.text! = String(rm.calorie)

        print("Inside DEQueue Cell ")
        
        cell.imagefood.image? =  UIImage(data: rm.foodImage!)!
        return cell
        
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        super.prepare(for: segue, sender: sender)
//
//        switch(segue.identifier ?? "") {
//
//        case "AddNewRoom":
//            os_log("Adding a new room.", log: OSLog.default, type: .debug)
//
//        case "ShowDetailRoom":
//            guard let detailVC = segue.destination as? RoomDetailViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            guard let tableCell = sender as? RoomViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//
//            guard let indexPath = tableView.indexPath(for: tableCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            do{
//                dataRoom              = try context.fetch(RoomModel.fetchRequest())
//                let selectedRoom      = dataRoom[indexPath.row]
//                detailVC.currentRoom  = selectedRoom
//            }
//            catch{
//                print("Error in Databse")
//            }
//
//        default:
//            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }

    

   

}
