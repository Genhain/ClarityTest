//
//  VolleyballVC.swift
//  ClarityTest
//
//  Created by Ben Fowler on 3/11/2016.
//  Copyright © 2016 BF. All rights reserved.
//

import UIKit

class VolleyballVC: UIViewController {

    @IBOutlet weak var webViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Volleyball"
        
        webViewTopConstraint.constant = UIScreen.main.bounds.height
        
        webView.loadRequest(URLRequest(url: URL(string:"https://gist.github.com/Genhain/8fa51af1481ea7daea1ea20d92a760ea")!))
    }
    
    @IBAction func clickHereTouched(_ sender: AnyObject) {
        webViewTopConstraint.constant = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        
        UIView.animate(withDuration: 0.45) { 
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
