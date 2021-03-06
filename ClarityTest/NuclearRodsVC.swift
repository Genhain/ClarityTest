//
//  NuclearRodsVC.swift
//  ClarityTest
//
//  Created by Ben Fowler on 4/11/2016.
//  Copyright © 2016 BF. All rights reserved.
//

import UIKit

class NuclearRodsVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var rodNumberLabel: UILabel!
    @IBOutlet weak var currentSetsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var rodNumberTextField: UITextField!
    @IBOutlet weak var fusedRodTextField: UITextField!
    @IBOutlet weak var secondFusedRodTextField: UITextField!
    @IBOutlet weak var addFusedRodsButton: UIButton!
    @IBOutlet weak var removeFusedRodsButton: UIButton!
    
    var numberOfRods: Int = 0
    var fusedRodPairs: [String] = []
    var totalFusedRods: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Nuclear Rods"
        currentSetsLabel.adjustsFontSizeToFitWidth = true
        removeFusedRodsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateCostLabel(rodPairs: fusedRodPairs)
        updateCurrentSetsLabel(rodPairs: [[]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fuelRodNumberEditChanged(_ sender: UITextField) {
        
        fusedRodPairs.removeAll()
        
        var rodNumber = 0
        
        if sender.text?.characters.count == 0 {
            rodNumberLabel.isHidden = true
            rodNumber = 0
        }
        else {
            rodNumber = Int(rodNumberTextField.text!)!
        }
        
        rodNumberLabel.isHidden = false
        
        numberOfRods = rodNumber
        
        rodNumberLabel.text =  String(format: "%i Rods to move", arguments: [numberOfRods])
        
        let rodMasses = parseRodMasses(numberOfRods: rodNumber, pairs: [])
        
        var stringOfRods:[[String]] = []
        for rodMass in rodMasses {
            stringOfRods.append(rodMass.rods)
        }
        
        updateCurrentSetsLabel(rodPairs: stringOfRods)
        updateCostLabel(rodPairs: fusedRodPairs)
    }
    
    @IBAction func firstFusedRodEditChanged(_ sender: UITextField) {
        validateTextFieldsInput(firstRodTextField: fusedRodTextField, secondRodTextField: secondFusedRodTextField)
    }
    
    @IBAction func secondFusedRodEditChanged(_ sender: AnyObject) {
        validateTextFieldsInput(firstRodTextField: fusedRodTextField, secondRodTextField: secondFusedRodTextField)
    }
    
    func validateTextFieldsInput(firstRodTextField: UITextField, secondRodTextField: UITextField) {
        
        var doTextFieldsHaveValidInput = true
        
        if firstRodTextField.text?.characters.count == 0 ||
            secondRodTextField.text?.characters.count == 0 {
            doTextFieldsHaveValidInput = false
        }
        
        if Int(firstRodTextField.text!) == 0  ||
            Int(secondRodTextField.text!) == 0 {
            doTextFieldsHaveValidInput = false
        }
        
        if Int(firstRodTextField.text!) == Int(secondRodTextField.text!) {
            doTextFieldsHaveValidInput = false
        }
        
        if !firstRodTextField.text!.isEmpty &&
            !secondRodTextField.text!.isEmpty {
            
            if Int(firstRodTextField.text!)! > numberOfRods ||
                Int(secondRodTextField.text!)! > numberOfRods {
                doTextFieldsHaveValidInput = false
            }
        }
        
        let rodMasses = parseRodMasses(numberOfRods: numberOfRods, pairs: fusedRodPairs)
        
        for rodMass in rodMasses {
            if rodMass.rods.contains(firstRodTextField.text!) &&
                rodMass.rods.contains(secondRodTextField.text!) {
                doTextFieldsHaveValidInput = false
            }
        }
        
        addFusedRodsButton.isEnabled = doTextFieldsHaveValidInput
    }
    
    @IBAction func addTouched(_ sender: UIButton) {
        
        let firstRodID = fusedRodTextField.text!
        let secondRodID = secondFusedRodTextField.text!
        
        fusedRodPairs.append("\(firstRodID) \(secondRodID)")
        
        let rodMasses = parseRodMasses(numberOfRods: numberOfRods, pairs: fusedRodPairs)
        
        var stringOfRods:[[String]] = []
        for rodMass in rodMasses {
            stringOfRods.append(rodMass.rods)
        }
        
        removeFusedRodsButton.isEnabled = true
        fusedRodTextField.text = ""
        secondFusedRodTextField.text = ""
        
        validateTextFieldsInput(firstRodTextField: fusedRodTextField, secondRodTextField: secondFusedRodTextField)
        updateCostLabel(rodPairs: fusedRodPairs)
        updateCurrentSetsLabel(rodPairs: stringOfRods)
    }
    
    @IBAction func removeTouched(_ sender: UIButton) {
        
        if fusedRodPairs.count == 1 {
            removeFusedRodsButton.isEnabled = false
        }
        
        _ = fusedRodPairs.popLast()
        
        let rodMasses = parseRodMasses(numberOfRods: numberOfRods, pairs: fusedRodPairs)
        
        var stringOfRods:[[String]] = []
        for rodMass in rodMasses {
            stringOfRods.append(rodMass.rods)
        }
        
        
        validateTextFieldsInput(firstRodTextField: fusedRodTextField, secondRodTextField: secondFusedRodTextField)
        updateCostLabel(rodPairs: fusedRodPairs)
        updateCurrentSetsLabel(rodPairs: stringOfRods)
    }
    
    @IBAction func newSetTouched(_ sender: AnyObject) {
        updateCostLabel(rodPairs: fusedRodPairs)
    }
    
    func updateCostLabel(rodPairs: [String]) {
        
        let cost = minimalCost(number: numberOfRods, pairs: rodPairs)
        costLabel.text = "Cost of moving \(numberOfRods) rods with \(totalFusedRods) fused is \(Int(cost))"
    }
    
    func updateCurrentSetsLabel(rodPairs: [[String]]) {
        
        if rodPairs.count == 0 {
            currentSetsLabel.text = ""
            return
        }
        
        currentSetsLabel.text = "{\(rodPairs)}"
    }
    
    // MARK: Test Function Answer
    func minimalCost(number: Int, pairs: [String]) -> Int {
        
        totalFusedRods = 0
        
        if number == 0 {
            return 0
        }
        
        let rodMasses = parseRodMasses(numberOfRods: number, pairs: pairs)
        
        var accumulatedCostOfFusedRods: Double = 0
        
        for rodMass in rodMasses {
            accumulatedCostOfFusedRods += ceil(sqrt(Double(rodMass.rods.count)))
            
            if rodMass.rods.count > 1 {
                for _ in rodMass.rods {
                    totalFusedRods += 1
                }
            }
        }
        
        return Int(accumulatedCostOfFusedRods)
    }
    
    func parseRodMasses(numberOfRods: Int, pairs: [String]) -> [RodMass] {
        
        var rodMasses: [RodMass] = []
        
        if numberOfRods == 0 {
            return rodMasses
        }
        
        for rodPair in pairs {
            let rodPairArray = rodPair.components(separatedBy: " ")
            
            let rodOne = rodPairArray[0]
            let rodTwo = rodPairArray[1]
            
            if rodMasses.count == 0 {
                let rodMass = RodMass.init(rods: [rodOne,rodTwo])
                rodMasses.append(rodMass)
                continue
            }
            
            var currentRodMass:RodMass = .init()
            var rodMassReplacementIndex = 0
            var didAddToExistingMass = false
            for (index,rodMass) in rodMasses.enumerated() {
                
                currentRodMass = rodMass
                
                if rodMass.rods.contains(rodOne) &&
                    rodMass.rods.contains(rodTwo) {
                    continue //Duplicate
                }
                
                rodMassReplacementIndex = index
                
                if rodMass.rods.contains(rodOne) &&
                    !rodMass.rods.contains(rodTwo) {
                    currentRodMass.rods.append(rodTwo)
                    didAddToExistingMass = true
                    break
                }
                
                if !rodMass.rods.contains(rodOne) &&
                    rodMass.rods.contains(rodTwo) {
                    currentRodMass.rods.append(rodOne)
                    didAddToExistingMass = true
                    break
                }
            }
            
            if !didAddToExistingMass {
                let newRodMass:RodMass = .init(rods: [rodOne,rodTwo])
                rodMasses.append(newRodMass)
            }
            else {
                rodMasses.remove(at: rodMassReplacementIndex)
                rodMasses.append(currentRodMass)
            }
        }
        
        for rodID in 1...numberOfRods {
            
            var doesContainRodID = false
            for rodMass in rodMasses {
                if rodMass.rods.contains(String(rodID)) {
                    doesContainRodID = true
                    break
                }
            }
            
            if !doesContainRodID {
                rodMasses.append(RodMass.init(rods: [String(rodID)]))
            }
        }
        
        return rodMasses
    }
}

struct RodMass {
    var rods: [String] = []
}
