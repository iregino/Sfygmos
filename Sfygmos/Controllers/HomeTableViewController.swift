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
    @IBOutlet weak var weigthUnitLabel: UILabel!
    @IBOutlet weak var measurementSitePicker: UIPickerView!
    @IBOutlet weak var measurementSiteLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    //Variables
    var isDatePickerHidden = true
    var isSystolicPickerHidden = true
    var isDiastolicPickerHidden = true
    var isPulsePickerHidden = true
    var isWeightPickerHidden = true
    var isMeasurementSitePickerHidden = true
    var systolicData = Array(80...200)
    var diastolicData = Array(40...140)
    var pulseData = Array(40...120)
    var weightInt = Array(20...500)
    var weightDouble = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    var weightUnit = ["lbs", "kgs"]
    var siteMeasurementData = ["Left Arm", "Right Arm", "Left Wrist", "Right Wrist"]
    var bloodPressure: BloodPressure?
    
    //Color variables
    let bpBlue = UIColor(red: 0.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let bpGreen = UIColor(red: 107.0/255.0, green: 214.0/255.0, blue: 0.0, alpha: 1.0)
    let bpYellow = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    let bpBrown = UIColor(red: 1.0, green: 200.0/255.0, blue: 0.0, alpha: 1.0)
    let bpOrange = UIColor(red: 1.0, green: 128.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    let bpRed = UIColor(red: 1.0, green: 64.0/255.0, blue: 0.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        self.systolicPicker.delegate = self
        self.systolicPicker.dataSource = self
        self.diastolicPicker.delegate = self
        self.diastolicPicker.dataSource = self
        self.pulsePicker.delegate = self
        self.pulsePicker.dataSource = self
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        self.measurementSitePicker.delegate = self
        self.measurementSitePicker.dataSource = self
        
        //Set properties with values passed through segue
        if let bloodPressure = bloodPressure {
            updateDateLabel(date: bloodPressure.bpDate)
            updateSystolicLabel(using: bloodPressure.systolic)
            updateDiastolicLabel(using: bloodPressure.diastolic)
            pulseLabel.text = String(bloodPressure.pulse)
            if let weight = bloodPressure.weight {
                weightLabel.text = String(weight)
                weigthUnitLabel.text = bloodPressure.weightUnit
            }
            measurementSiteLabel.text = bloodPressure.measurementSite
            notesTextView.text = bloodPressure.notes
        } else {
            dateTimePicker.date = Date()
            updateDateLabel(date: dateTimePicker.date)
        }
        
        //Set pickers to specific values
        systolicPicker.selectRow(40, inComponent:0, animated: true)
        diastolicPicker.selectRow(40, inComponent: 0, animated: true)
        pulsePicker.selectRow(32, inComponent: 0, animated: true)
        weightPicker.selectRow(55, inComponent: 0, animated: true)
        weightPicker.selectRow(0, inComponent: 1, animated: true)
        measurementSitePicker.selectRow(0, inComponent: 0, animated: true)
        
    } //end viewDidLoad()
    
    //MARK: - Date Picker Methods
    
    @IBAction func dateTimePickerChanged(_ sender: UIDatePicker) {
        
        updateDateLabel(date: dateTimePicker.date)
    } //end dateTimePickerChanged()
    
    //Update date label with the correct date and time format
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
    
    //Determines the number of pickerview items per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return systolicData.count
        } else if pickerView.tag == 2 {
            return diastolicData.count
        } else if pickerView.tag == 3 {
            return pulseData.count
        } else if pickerView.tag == 4 {
            if component == 0 {
                return weightInt.count
            } else if component == 1 {
                return weightDouble.count
            } else {
                return weightUnit.count
            }
        } else {
            return siteMeasurementData.count
        }
    } //end pickerView(:numberOfRowsInComponent:)
    
    //Populates pickerview with appropriate values
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return String(systolicData[row])
        } else if pickerView.tag == 2 {
            return String(diastolicData[row])
        } else if pickerView.tag == 3 {
            return String(pulseData[row])
        } else if pickerView.tag == 4 {
            if component == 0 {
                return String(weightInt[row])
            } else if component == 1 {
                return String(weightDouble[row])
            } else {
                return String (weightUnit[row])
            }
        } else {
            return siteMeasurementData[row]
        }
    } //end pickerView(:titleForRow:)
    
    //Set selected picker view value to the property labels
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            updateSystolicLabel(using: systolicData[row])
        } else if pickerView.tag == 2 {
            updateDiastolicLabel(using: diastolicData[row])
        } else if pickerView.tag == 3 {
            pulseLabel.text = String(pulseData[row])
        } else if pickerView.tag == 4 {
            let weightIntSelected = weightInt[weightPicker.selectedRow(inComponent: 0)]
            let weightDoubleSelected = weightDouble[weightPicker.selectedRow(inComponent: 1)]
            weightLabel.text = String(Double(weightIntSelected) + weightDoubleSelected)
            let weightUnitSelected = weightUnit[weightPicker.selectedRow(inComponent: 2)]
            weigthUnitLabel.text = weightUnitSelected
        } else {
            measurementSiteLabel.text = String(siteMeasurementData[row])
        }
    } //end pickerView(:didSelectRow:)
    
    
    // MARK: - Table view data source

    //Adjust cell row height accordingly
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let smallCellHeight = CGFloat(55)
        let normalCellHeight = CGFloat(65)
        let mediumCellHeight = CGFloat(125)
        let largeCellHeight = CGFloat(210)
        
        switch (indexPath) {
        case [0,0]: //Date Cell
            return isDatePickerHidden ? smallCellHeight : largeCellHeight
        case [0,1]: //Systolic Cell
            return isSystolicPickerHidden ? normalCellHeight: largeCellHeight
        case [0,2]: //Diastolic Cell
            return isDiastolicPickerHidden ? normalCellHeight : largeCellHeight
        case [0,3]: //Pulse Cell
            return isPulsePickerHidden ? normalCellHeight : largeCellHeight
        case [1,0]: //Weight Cell
            return isWeightPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: //Site Measurement Cell
            return isMeasurementSitePickerHidden ? smallCellHeight : mediumCellHeight
        case [3,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        } //end switch
    } //end tableView(:heighForRowAt:)
    
    //Update tableView when data is selected from picker view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath) {
        case [0,0]:
            isDatePickerHidden = !isDatePickerHidden
            dateTimeLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
        case [0,1]:
            isSystolicPickerHidden = !isSystolicPickerHidden
        case [0,2]:
            isDiastolicPickerHidden = !isDiastolicPickerHidden
        case [0,3]:
            isPulsePickerHidden = !isPulsePickerHidden
            pulseLabel.textColor = isPulsePickerHidden ? .black : tableView.tintColor
        case [1,0]:
            isWeightPickerHidden = !isWeightPickerHidden
            weightLabel.textColor = isWeightPickerHidden ? .black : tableView.tintColor
        case [2,0]:
            isMeasurementSitePickerHidden = !isMeasurementSitePickerHidden
            measurementSiteLabel.textColor = isMeasurementSitePickerHidden ? .black : tableView.tintColor
        default:
            break
        } //end switch
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    } //end tableView(:didSelectRowAt:)

    // Set the header spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // Set the footer spacing between sections
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    //Update text color based on systolic value to provide user an instant feedback
    func updateSystolicLabel(using systolic: Int) {
        systolicLabel.text = String(systolic)
        switch systolic {
        case 0...89: //Low blood pressure
            systolicLabel.textColor = bpBlue
        case 90...119: //Normal pressure
            systolicLabel.textColor = bpGreen
        case 120...129: //Elevated pressure
            systolicLabel.textColor = bpYellow
        case 130...139: //Stage 1 hypertension
            systolicLabel.textColor = bpBrown
        case 140...179: //Stage 2 hypertension
            systolicLabel.textColor = bpOrange
        default: //Hypertension crisis
            systolicLabel.textColor = bpRed
        } //end switch
    } //end updateSystolicLabel()
    
    //Update text color based on diastolic value to provide user an instant feedback
    func updateDiastolicLabel(using diastolic: Int) {
        diastolicLabel.text = String(diastolic)
        switch diastolic {
        case 0...59: //Low blood pressure
            diastolicLabel.textColor = bpBlue
        case 60...79: //Normal pressure
            diastolicLabel.textColor = bpGreen
        case 80...89: //Elevated pressure
            diastolicLabel.textColor = bpYellow
        case 90...99: //Stage 1 hypertension
            diastolicLabel.textColor = bpBrown
        case 100...119: //Stage 2 hypertension
            diastolicLabel.textColor = bpOrange
        default: //Hypertension crisis
            diastolicLabel.textColor = bpRed
        } //end switch
    } //end updateDiastolicLabel()
    
    
    // MARK: - Navigation
   
    /*
    //Alert user with total amount before submitting order
    let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
    self.uploadOrder()
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
    
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                } //end if-let
            }
        } //end closure
    } //end uploadOrder()
    */
    
    //Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let bpDate = dateTimePicker.date
        let systolic = systolicLabel.text!
        let diastolic = diastolicLabel.text!
        let pulse = pulseLabel.text!
        let weight = Double(weightLabel.text!)
        let weightUnit = weigthUnitLabel.text
        let measurementSite = measurementSiteLabel.text!
        let notes = notesTextView.text!
        
        bloodPressure = BloodPressure(bpDate: bpDate, systolic: Int(systolic)!, diastolic: Int(diastolic)!, pulse: Int(pulse)!, weight: weight, weightUnit: weightUnit, measurementSite: measurementSite, notes: notes)
    } //end prepare(for segue:)
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }

} //end HomeTableViewController{}
