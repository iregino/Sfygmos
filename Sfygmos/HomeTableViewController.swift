//
//  HomeTableViewController.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/11/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Outlets
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var systolicPicker: UIPickerView!
    @IBOutlet weak var systolicLabel: UILabel!
    @IBOutlet weak var diastolicPicker: UIPickerView!
    @IBOutlet weak var diastolicLabel: UILabel!
    @IBOutlet weak var pulsePicker: UIPickerView!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var siteMeasurementPicker: UIPickerView!
    @IBOutlet weak var siteMeasurementLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    //Variables
    var isDatePickerHidden = true
    var isSystolicPickerHidden = true
    var isDiastolicPickerHidden = true
    var isPulsePickerHidden = true
    var isWeightPickerHidden = true
    var isSiteMeasurementPickerHidden = true
    var systolicValues = Array(80...200)
    var diastolicValues = Array(40...140)
    var pulseValues = Array(40...120)
    var weightInt = Array(20...500)
    var weightDouble = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    var weightUnit = ["lbs", "kgs"]
    var siteMeasurementValues = ["Left Arm", "Right Arm", "Left Wrist", "Right Wrist"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.systolicPicker.delegate = self
        self.systolicPicker.dataSource = self
        self.diastolicPicker.delegate = self
        self.diastolicPicker.dataSource = self
        self.pulsePicker.delegate = self
        self.pulsePicker.dataSource = self
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        self.siteMeasurementPicker.delegate = self
        self.siteMeasurementPicker.dataSource = self
        
        systolicPicker.selectRow(40, inComponent:0, animated: true)
        diastolicPicker.selectRow(40, inComponent: 0, animated: true)
        pulsePicker.selectRow(32, inComponent: 0, animated: true)
        weightPicker.selectRow(55, inComponent: 0, animated: true)
        weightPicker.selectRow(0, inComponent: 1, animated: true)
        siteMeasurementPicker.selectRow(0, inComponent: 0, animated: true)
        
        dateTimePicker.date = Date()
        updateDateLabel(date: dateTimePicker.date)

    } //end viewDidLoad()
    
    
    @IBAction func dateTimePickerChanged(_ sender: UIDatePicker) {
        
        updateDateLabel(date: dateTimePicker.date)
    } //end dateTimePickerChanged()
    
    func updateDateLabel(date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        dateTimeLabel.text = formatter.string(from: date)

    } //end updateDueDateLabel()

    
    //MARK: - Picker View Delegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 4 {
            return 3
        } else {
            return 1
        }
    } //end numberOfComponents()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return systolicValues.count
        } else if pickerView.tag == 2 {
            return diastolicValues.count
        } else if pickerView.tag == 3 {
            return pulseValues.count
        } else if pickerView.tag == 4 {
            if component == 0 {
                return weightInt.count
            } else if component == 1 {
                return weightDouble.count
            } else {
                return weightUnit.count
            }
        } else {
            return siteMeasurementValues.count
        }
    } //end pickerView(:numberOfRowsInComponent:)
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return String(systolicValues[row])
        } else if pickerView.tag == 2 {
            return String(diastolicValues[row])
        } else if pickerView.tag == 3 {
            return String(pulseValues[row])
        } else if pickerView.tag == 4 {
            if component == 0 {
                return String(weightInt[row])
            } else if component == 1 {
                return String(weightDouble[row])
            } else {
                return String (weightUnit[row])
            }
        } else {
            return siteMeasurementValues[row]
        }
    } //end pickerView(:titleForRow:)
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            systolicLabel.text = String(systolicValues[row])
        } else if pickerView.tag == 2 {
            diastolicLabel.text = String(diastolicValues[row])
        } else if pickerView.tag == 3 {
            pulseLabel.text = String(pulseValues[row])
        } else if pickerView.tag == 4 {
            let weightIntSelected = weightInt[weightPicker.selectedRow(inComponent: 0)]
            let weightDoubleSelected = weightDouble[weightPicker.selectedRow(inComponent: 1)]
            weightLabel.text = String(Double(weightIntSelected) + weightDoubleSelected)
        } else {
            siteMeasurementLabel.text = String(siteMeasurementValues[row])
        }
    } //end pickerView(:didSelectRow:)
    
    
    // MARK: - Table view data source

    // Adjust row height for due date cell and notes cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(60)
        let mediumCellHeight = CGFloat(160)
        let largeCellHeight = CGFloat(210)
        
        switch (indexPath) {
        case [0,0]: //Date Cell
            return isDatePickerHidden ? normalCellHeight : largeCellHeight
        case [0,1]: //Systolic Cell
            return isSystolicPickerHidden ? normalCellHeight: largeCellHeight
        case [0,2]: //Diastolic Cell
            return isDiastolicPickerHidden ? normalCellHeight : largeCellHeight
        case [0,3]: //Pulse Cell
            return isPulsePickerHidden ? normalCellHeight : largeCellHeight
        case [1,0]: //Weight Cell
            return isWeightPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: //Site Measurement Cell
            return isSiteMeasurementPickerHidden ? normalCellHeight : mediumCellHeight
        case [3,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        } //end switch
    } //end tableView(:heighForRowAt:)
    
    // Update tableView when date is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath) {
        case [0,0]:
            isDatePickerHidden = !isDatePickerHidden
            dateTimeLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
        case [0,1]:
            isSystolicPickerHidden = !isSystolicPickerHidden
            systolicLabel.textColor = isSystolicPickerHidden ? .black : tableView.tintColor
        case [0,2]:
            isDiastolicPickerHidden = !isDiastolicPickerHidden
            diastolicLabel.textColor = isDiastolicPickerHidden ? .black : tableView.tintColor
        case [0,3]:
            isPulsePickerHidden = !isPulsePickerHidden
            pulseLabel.textColor = isPulsePickerHidden ? .black : tableView.tintColor
        case [1,0]:
            isWeightPickerHidden = !isWeightPickerHidden
            weightLabel.textColor = isWeightPickerHidden ? .black : tableView.tintColor
        case [2,0]:
            isSiteMeasurementPickerHidden = !isSiteMeasurementPickerHidden
            siteMeasurementLabel.textColor = isSiteMeasurementPickerHidden ? .black : tableView.tintColor
        default:
            break
        } //end switch
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    } //end tableView(:didSelectRowAt:)

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
