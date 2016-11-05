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
        
        if addNumberTextField.text?.characters.count == 0 {
            return
        }
        
        let numbertoAddToSequence = self.addNumberTextField.text!
        
        var format = "%@"
        
        if userInputSequence.characters.count > 0 {
            format = ", %@"
        }
        
        userInputSequence.append(String(format: format, arguments: [numbertoAddToSequence]))
        
        sequenceLabel.text = userInputSequence
        
        if userInputSequence.characters.count > 1 && (differenceTextField.text?.characters.count)! > 0 {
            self.updateDifferenceCount(withDifference: differenceToFind)
        }
        
        sequenceLabel.isHidden = false
        
        addNumberTextField.text = ""
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
        
        if userInputSequence.characters.count > 1 && (differenceTextField.text?.characters.count)! > 0 {
            self.updateDifferenceCount(withDifference: differenceToFind)
        }
    }
    
    private var differenceToFind = 0
    @IBAction func differenceTextFieldValueChanged(_ sender: UITextField) {
        
        if sender.text?.characters.count == 0 {
            differenceCountLabel.isHidden = true
            differenceToFind = 0
            return
        }
        
        if userInputSequence.characters.count == 0 {
            differenceCountLabel.isHidden = true
            differenceToFind = 0
            return
        }
        
        differenceToFind = Int(sender.text!)!
        
        self.updateDifferenceCount(withDifference: differenceToFind)
    }
    
    func updateDifferenceCount(withDifference difference: Int)
    {
        let sequenceNumbers = userInputSequence.components(separatedBy: ", ")
        
        let sequenceNumbersAsIntegers = sequenceNumbers.map { (string) -> Int in
            return Int(string)!
        }
        
        let differencePairCount = self.countPairs(numbers: sequenceNumbersAsIntegers, differenceToCount: difference)
        
        differenceCountLabel.text = String(format: "Number of Pairs with the difference %i is %i", arguments: [difference,differencePairCount])
        
        differenceCountLabel.isHidden = false
    }
    
    func countPairs(numbers: [Int], differenceToCount: Int) -> Int {
        
        var pairsWithDifferenceCount = 0
        var previouslyCountedPairs = [CountedPair]()
        
        outerloop: for (index, element) in numbers.enumerated() {
            innerLoop: for (innerIndex, innerElement) in numbers.enumerated() {
                if index == innerIndex {
                    continue innerLoop
                }
                
                if (element + differenceToCount) == innerElement {
                    
                    let countedPair: CountedPair = .init(element, innerElement)
                    
                    if previouslyCountedPairs.count == 0 {
                        previouslyCountedPairs.append(countedPair)
                        pairsWithDifferenceCount += 1
                    }
                    else {
                        var isUniquePair = true
                        for pair in previouslyCountedPairs {
                            
                            if (pair.firstElement == element || pair.firstElement == innerElement) &&
                               (pair.secondElement == element || pair.secondElement == innerElement)
                            {
                                isUniquePair = false
                                break
                            }
                        }
                        
                        if isUniquePair {
                            pairsWithDifferenceCount += 1
                            previouslyCountedPairs.append(countedPair)
                        }
                    }
                }
            }
        }
        
        return pairsWithDifferenceCount
    }

}

struct CountedPair {
    var firstElement: Int = 0
    var secondElement: Int = 0
    
    init(_ firstElement: Int,_ secondElement: Int) {
        self.firstElement = firstElement
        self.secondElement = secondElement
    }
}


