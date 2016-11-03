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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Counting Pairs"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
