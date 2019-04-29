//
//  BloodPressureHistoryTableViewController.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/19/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    //Variables
    var bpHistory = [BloodPressure]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedBPs = BloodPressure.loadBloodPressures() {
            bpHistory = savedBPs //load saved blood pressures from documents directory
        }
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    } //end viewDidLoad()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bpHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Dequeue cell and force downcast to the BloddPressureTableViewCell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureCell", for: indexPath) as! BloodPressureTableViewCell
        
        //Fetch model object to display
        let bloodPressure = bpHistory[indexPath.row]
        
        //Configure cell
        cell.update(with: bloodPressure)
        cell.showsReorderControl = true

        //Return cell to view
        return cell
    }
    
    //Override to set row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    } //end tableView(:heightForRowAt:)
    
    //Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } //end tableView(:canEditRowAt:)

    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source and view
            bpHistory.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            BloodPressure.saveBloodPressures(bpHistory)
        } //end if
    } //end tableView(:editingStyle:)
    

    // MARK: - Navigation

    //Save the information passed by segue from from view
    @IBAction func unwindToBloodPressureHistory(segue: UIStoryboardSegue) {
     
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! HomeTableViewController
        
        if let bloodPressure = sourceVC.bloodPressure {
            // Save any changes to existing
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                bpHistory[selectedIndexPath.row] = bloodPressure
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Save new
                let newIndexPath = IndexPath(row: bpHistory.count, section: 0)
                bpHistory.append(bloodPressure)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            } //end if-let
        } //end if-let
    
        BloodPressure.saveBloodPressures(bpHistory)
        
    } //end unwindToBloodPressureHistory()
     
    //Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let bpDetailVC = segue.destination as! HomeTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedBP = bpHistory[indexPath.row]
            bpDetailVC.bloodPressure = selectedBP
        } //end if-let
    } //end prepare(for segue:)

} //end HistoryTableViewController{}
