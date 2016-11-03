//
//  VolleyBallVC.swift
//  ClarityTest
//
//  Created by Ben Fowler on 3/11/2016.
//  Copyright © 2016 BF. All rights reserved.
//

import UIKit

class CountingPairsVC: UIViewController
{
    @IBOutlet weak var addNumberTextField: UITextField!
    @IBOutlet weak var differenceTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var sequenceLabel: UILabel!
    @IBOutlet weak var differenceCountLabel: UILabel!
    
    
    private var userInputSequence: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Counting Pairs"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTouched(_ sender: AnyObject) {
        
        let numbertoAddToSequence = self.addNumberTextField.text!
        
        var format = "%@"
        
        if userInputSequence.characters.count > 0 {
            format = ", %@"
        }
        
        userInputSequence.append(String(format: format, arguments: [numbertoAddToSequence]))
        
        sequenceLabel.text = userInputSequence
        
        sequenceLabel.isHidden = false
    }
    
    @IBAction func removeButtonTouched(_ sender: AnyObject) {
        var currentSequence: String = userInputSequence
        
        
        if currentSequence.characters.count <= 1 {
            currentSequence = ""
        }
        else {
            let sequenceNumbers = currentSequence.components(separatedBy: ", ")
            let numberToRemove = sequenceNumbers.last
            let numberOfDigits = numberToRemove?.characters.count
            let numberOfcharactersToRemove = numberOfDigits! + 2
            currentSequence.removeSubrange(currentSequence.index(currentSequence.endIndex, offsetBy: -numberOfcharactersToRemove)..<currentSequence.endIndex)
        }
        
        sequenceLabel.text = currentSequence
        userInputSequence = currentSequence
        
        if sequenceLabel.text?.characters.count == 0 {
            sequenceLabel.isHidden = true
        }
    }
}

extension CountingPairsVC
{
    
}


