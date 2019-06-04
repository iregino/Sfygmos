//
//  RadioButton.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/30/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import UIKit

class RadioButton: UIButton {

    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    } //end awakeFromNib()
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    } //end unselectAlternateButtons()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    } //endtouchesBegan()
    
    func toggleButton(){
        self.isSelected = !isSelected
    } //end toggleButton()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.backgroundColor = UIColor(red: 0.0, green: 97.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            } else {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.backgroundColor = UIColor.white.cgColor
            } //end if
        }
    } //end isSelected:

}
