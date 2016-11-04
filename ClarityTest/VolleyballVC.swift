//
//  VolleyballVC.swift
//  ClarityTest
//
//  Created by Ben Fowler on 3/11/2016.
//  Copyright © 2016 BF. All rights reserved.
//

import UIKit

class VolleyballVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Volleyball"
        
        let tree = Node.init(leftValue: 0, rightValue: 0, left: nil, leftMax: 3, right: nil, rightMax: 25)
        tree.construct()
        
        
        print(tree.count)
        print(tree.leafCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func teamAScoreEditChanged(_ sender: AnyObject) {
    }
    @IBAction func teamBScoreEditChanged(_ sender: AnyObject) {
    }
}


class Node {
    let leftValue: Int
    let rightValue: Int
    var left: Node?
    let leftMax: Int
    var right: Node?
    let rightMax: Int
    var ceiling: Int
    
    init(leftValue: Int, rightValue: Int, left: Node?, leftMax: Int, right: Node?, rightMax: Int) {
        self.leftValue = leftValue
        self.leftMax = leftMax
        self.rightValue = rightValue
        self.rightMax = rightMax
        self.left = left
        self.right = right
        
        self.ceiling = max(self.leftMax, self.rightMax)
    }
    
    func construct() {
        add(leftValue: leftValue, rightValue: rightValue)
    }
    
    func add(leftValue: Int, rightValue: Int) {
        if self.leftValue < self.leftMax {
            if (self.leftValue + 1) == ceiling && self.rightValue != self.rightMax{
                return
            }
            
            Node.addNode(node: &left, leftValue: leftValue + 1, rightValue: rightValue, leftMax: leftMax, rightMax: rightMax)
        }
        
        if self.rightValue < self.rightMax {
            if (self.rightValue + 1) == ceiling && self.leftValue != self.leftMax{
                return
            }
            
            Node.addNode(node: &right, leftValue: leftValue, rightValue: rightValue+1, leftMax: leftMax, rightMax: rightMax)
        }
    }
    
    static func addNode( node: inout Node?, leftValue: Int, rightValue: Int, leftMax: Int, rightMax: Int) {
        if node == nil {
            node = Node(leftValue: leftValue, rightValue: rightValue, left: nil, leftMax: leftMax, right: nil, rightMax: rightMax)
            node!.construct()
        } else {
            node!.add(leftValue: leftValue, rightValue: rightValue)
        }
    }
}

extension Node: CustomStringConvertible {    
    var count: Int {
        if left != nil && right != nil {
            return left!.count + 1 + right!.count + 1
        }
        
        if left != nil {
            return left!.count + 1
        }
        else if right != nil {
            return right!.count + 1
        }
        
        return 0
    }
    
    var leafCount: Int {
        if left == nil && right == nil {
            return 1
        }
        else if left != nil && right == nil {
            return left!.leafCount
        }
        else if left == nil && right != nil {
            return right!.leafCount
        }
            
        return (left?.leafCount)! + (right?.leafCount)!
        
    }
    
 
}
