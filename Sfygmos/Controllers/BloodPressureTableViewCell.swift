//
//  BloodPressureTableViewCell.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/24/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import UIKit

class BloodPressureTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var bpDateLabel: UILabel!
    @IBOutlet weak var bloodPressureLabel: UILabel!
    
    //Color variables
    let bpBlue = UIColor(red: 0.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let bpGreen = UIColor(red: 128.0/255.0, green: 1.0, blue: 0.0, alpha: 1.0)
    let bpYellow = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    let bpBrown = UIColor(red: 1.0, green: 191.0/255.0, blue: 0.0, alpha: 1.0)
    let bpOrange = UIColor(red: 1.0, green: 128.0/255.0, blue: 0.0, alpha: 1.0)
    let bpRed = UIColor(red: 1.0, green: 64.0/255.0, blue: 0.0, alpha: 1.0)
    
    //Set cell properties with blood pressure values
    func update(with bloodPressure: BloodPressure) {
        
        bpDateLabel.text = BloodPressure.bpDateFormatter.string(from: bloodPressure.bpDate)
        
        let bloodPressureText = "\(bloodPressure.systolic) / \(bloodPressure.diastolic) mmHg"
        let attributedBPText = NSMutableAttributedString(string: bloodPressureText)
        
        //Set text color based on the systolic value for user feedback
        let systolic = bloodPressure.systolic
        switch systolic {
        case 0...89: //Low blood pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpBlue, range: NSRange(location: 0, length: 2))
        case 90...119: //Normal pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpGreen, range: NSRange(location: 0, length: 3))
        case 120...129: //Elevated pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpYellow, range: NSRange(location: 0, length: 3))
        case 130...139: //Stage 1 hypertension
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpBrown, range: NSRange(location: 0, length: 3))
        case 140...179: //Stage 2 hypertension
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpOrange, range: NSRange(location: 0, length: 3))
        default: //Hypertension crisis
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpRed, range: NSRange(location: 0, length: 3))
        } //end switch
        
        //Set text color based on the diastolic value for user feedback
        let diastolicIndex: Int = String(bloodPressure.systolic).count + 3
        let diastolic = bloodPressure.diastolic
        switch diastolic {
        case 0...59: //Low blood pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpBlue, range: NSRange(location: diastolicIndex, length: 2))
        case 60...79: //Normal pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpGreen, range: NSRange(location: diastolicIndex, length: 2))
        case 80...89: //Elevated pressure
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpYellow, range: NSRange(location: diastolicIndex, length: 2))
        case 90...99: //Stage 1 hypertension
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpBrown, range: NSRange(location: diastolicIndex, length: 2))
        case 100...119: //Stage 2 hypertension
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpOrange, range: NSRange(location: diastolicIndex, length: 3))
        default: //Hypertension crisis
            attributedBPText.addAttribute(NSAttributedString.Key.foregroundColor, value: bpRed, range: NSRange(location: diastolicIndex, length: 3))
        } //end switch
        
        //Change font size of blood pressure unit to de-emphasize
        attributedBPText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: bloodPressureText.count - 4, length: 4))
        
        bloodPressureLabel.attributedText = attributedBPText
        
    } //end update()
} //end BloodPressureTableViewCell{}
