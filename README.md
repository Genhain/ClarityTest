# ClarityTest

If you dont wish to rummage through the code, or can't or do not want to run the project here are the answers directly

## Counting Pairs

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

## Volleyball match

    static func volleyball(A: Int, B: Int) -> Int {
        let treeRootNode = Node.init(leftValue: 0, rightValue: 0, left: nil, leftMax: A, right: nil, rightMax: B)

        treeRootNode.construct()

        return treeRootNode.leafCount
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

    extension Node {
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

## Nuclear Rods

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

    struct RodMass {
        var rods: [String] = []
    }
