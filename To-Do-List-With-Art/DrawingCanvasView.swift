//
//  DrawingCanvasView.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/23/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit
//this is a view
@IBDesignable
class DrawingCanvasView: UIView {
    
    @IBInspectable
    var step: Int = 0 { didSet {setNeedsDisplay(); setNeedsLayout() /*use when need to redraw*/ }}
    
    var colorBlueArray = [#colorLiteral(red: 0.7458879352, green: 0.9206150174, blue: 0.937274754, alpha: 1), #colorLiteral(red: 0.850831449, green: 0.9661218524, blue: 0.6844211221, alpha: 1), #colorLiteral(red: 0.6589035988, green: 0.9218665361, blue: 0.6415066123, alpha: 1), #colorLiteral(red: 0.7725490196, green: 1, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.7725490196, green: 0.968627451, blue: 1, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0.862745098, blue: 1, alpha: 1), #colorLiteral(red: 0.7960784314, green: 0.8196078431, blue: 1, alpha: 1), #colorLiteral(red: 0.850831449, green: 0.9661218524, blue: 0.6844211221, alpha: 1), #colorLiteral(red: 0.6589035988, green: 0.9218665361, blue: 0.6415066123, alpha: 1), #colorLiteral(red: 0.7725490196, green: 1, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.7725490196, green: 0.968627451, blue: 1, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0.862745098, blue: 1, alpha: 1), #colorLiteral(red: 0.7960784314, green: 0.8196078431, blue: 1, alpha: 1)]
    var colorMorningArray = [#colorLiteral(red: 0.9970012307, green: 0.854180038, blue: 0.8097401261, alpha: 1), #colorLiteral(red: 1, green: 0.7955614924, blue: 0.6226267219, alpha: 1), #colorLiteral(red: 1, green: 0.9647058824, blue: 0.6039215686, alpha: 1), #colorLiteral(red: 0.9772595763, green: 0.9075548053, blue: 0.7779645324, alpha: 1), #colorLiteral(red: 0.9772595763, green: 0.9075548053, blue: 0.7779645324, alpha: 1), #colorLiteral(red: 0.9970012307, green: 0.854180038, blue: 0.8097401261, alpha: 1), #colorLiteral(red: 1, green: 0.7955614924, blue: 0.6226267219, alpha: 1), #colorLiteral(red: 1, green: 0.9647058824, blue: 0.6039215686, alpha: 1), #colorLiteral(red: 1, green: 0.77765733, blue: 0.7933813334, alpha: 1), #colorLiteral(red: 1, green: 0.77765733, blue: 0.7933813334, alpha: 1), #colorLiteral(red: 0.9917916656, green: 0.8281347156, blue: 0.6977577209, alpha: 1), #colorLiteral(red: 0.9917916656, green: 0.8281347156, blue: 0.6977577209, alpha: 1)]
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        var caseStep = 0
        var modulo = 0
        colorBlueArray.shuffle()
        colorMorningArray.shuffle()
        
        
        if (step <= 25 && step > 0) {
            caseStep = 1 //Spiral
        } else if (step % 100 <= 75 && step % 100 > 25) {
            caseStep = 2 //Spiral and Tree
        } else if (step % 100 == 0 || step % 100 > 75) && step > 75 {
            caseStep = 3 //Firework and Tree
            if step % 100 == 0 {
                modulo = 25
            } else {
                modulo = step % 100 - 75
            }
        } else if (step > 100 && (step % 100 <= 25)) {
            caseStep = 4
        }
        
        switch (caseStep) {
        case 1: drawSpiral(step)
        case 2: drawSpiral(25); drawTree(step % 100 - 25)
        case 3: drawTree(50); drawFireworks(modulo)
        case 4: drawFireworks(25); drawSpiral(step % 100)
        default: drawSpiral(0)
        }
    
    }

    func drawTree(_ step: Int) {
        var root = CGPoint(x: bounds.width / 2, y: bounds.height - bounds.height * 0.1)
        var path = UIBezierPath()
        var savedPoint: CGPoint
        path.lineWidth = 9.0
        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
        #colorLiteral(red: 0.913316071, green: 0.7689850926, blue: 0.5155162811, alpha: 1).setStroke()
        
        //Root -- 12 steps
        path.move(to: root)
        var rootArrayIndex = 0
        let rootArray = makeRootArray()
        for index in 1..<min(13, step + 1) {
            if index % 2 != 0 {
                let midPoint = makeMidPoint(root, rootArray[rootArrayIndex])
                path.addLine(to: midPoint)
                path.stroke()
            } else {
                path.addLine(to: rootArray[rootArrayIndex])
                path.stroke()
                rootArrayIndex += 1
                path.move(to: root)
            }
        }
        
        //Stem -- 14 steps
        if step > 12 {
            path = UIBezierPath()
            path.move(to: root)
            path.lineWidth = 16.0
            savedPoint = CGPoint(x: root.x, y: root.y - bounds.height * 0.4)
            let increment = bounds.height * 0.4 / 14
            var deltaY = increment
            for _ in 1..<min(15, step - 12 + 1) {
                savedPoint = CGPoint(x: root.x, y: root.y - deltaY)
                deltaY += increment
                path.addLine(to: savedPoint)
                path.stroke()
            }
            root = CGPoint(x: root.x, y: root.y - bounds.height * 0.4 + (root.y - bounds.height * 0.4) * 0.01)
        }
        
        //Branches -- 2 steps to each midway point, 3 pairs of branches --> 24 steps
        if step > 26 {
            path = UIBezierPath()
            path.lineWidth = 10.0
            path.move(to: root)
            var root2 = root
            let branchLeftArray = makeLeftBranchArray(root.y)
            let branchRightArray = makeRightBranchArray(root.y)
            var branchIndex = 0
            for index in 1..<min(25, step - 26 + 1) {
                if index % 4 == 1 {
                    let midpoint = makeMidPoint(root2, branchLeftArray[branchIndex])
                    path.addLine(to: midpoint)
                    path.stroke()
                } else if index % 4 == 2 {
                    path.addLine(to: branchLeftArray[branchIndex])
                    path.stroke()
                    if branchIndex % 2 == 0 {
                        root2 = root
                        path.move(to: root2)
                    } else {
                        root2 = branchRightArray[branchIndex-1]
                        path.move(to: root2)
                    }
                } else if index % 4 == 3 {
                    let midpoint = makeMidPoint(root2, branchRightArray[branchIndex])
                    path.addLine(to: midpoint)
                    path.stroke()
                } else {
                    path.addLine(to: branchRightArray[branchIndex])
                    path.stroke()
                    branchIndex += 1
                    if branchIndex % 2 == 0 {
                        root2 = root
                        path.move(to: root2)
                    } else {
                        root2 = branchLeftArray[branchIndex-1]
                        path.move(to: root2)
                    }
                }
            }
        }
    }
    
    func drawSpiral(_ step: Int) {
        var ccw: Bool = true
        var stepper = step
        
        for _ in stride(from: 0, to: step + 5, by: 5) {
            var center = CGPoint(x: (bounds.width).arc4random, y: (bounds.height - 100).arc4random)
            var startAngle = 3*CGFloat(Double.pi)/2
            var endAngle = CGFloat(0)
            var radius = randomNumberBetweenRange((bounds.width / 135), (bounds.width / 90)) //Initial radius
            
            // Use UIBezierPath to create the CGPath for the layer
            // The path should be the entire spiral
            
            var path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            // Begin arc
            if ccw {
                path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                endAngle = CGFloat(Double.pi)
            } else {
                path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            }
            
            if stepper > 0 {
                if ccw {
                    for _ in 0..<(min(4, stepper) * 2) {
                        
                        startAngle = endAngle
                        
                        switch startAngle {
                        case 0:
                            center = CGPoint(x: center.x - radius/2, y: center.y)
                            endAngle = 3*CGFloat(Double.pi)/2
                        case CGFloat(Double.pi):
                            center = CGPoint(x: center.x + radius/2, y: center.y)
                            endAngle = CGFloat(Double.pi)/2
                        case CGFloat(Double.pi)/2:
                            center = CGPoint(x: center.x , y: center.y - radius/2)
                            endAngle = 0
                        case 3*CGFloat(Double.pi)/2:
                            center = CGPoint(x: center.x, y: center.y + radius/2)
                            endAngle = CGFloat(Double.pi)
                        default:
                            center = CGPoint(x:bounds.width/3 + bounds.width/3, y: bounds.height/3)
                        }
                        
                        radius = 1.5 * radius
                        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: false)
                        path.lineWidth = 30.0
                        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
                        colorBlueArray[Int(CGFloat(colorBlueArray.count).arc4random)].setStroke()
                        path.stroke()
                        
                    }
                    ccw = false
                } else {
                    for _ in 0..<(min(4, stepper) * 2) {
                        
                        startAngle = endAngle
                        
                        switch startAngle {
                        case 0, 2*CGFloat(Double.pi):
                            center = CGPoint(x: center.x - radius/2, y: center.y)
                            endAngle = CGFloat(Double.pi)/2
                        case CGFloat(Double.pi):
                            center = CGPoint(x: center.x + radius/2, y: center.y)
                            endAngle = 3*CGFloat(Double.pi)/2
                        case CGFloat(Double.pi)/2:
                            center = CGPoint(x: center.x  , y: center.y - radius/2)
                            endAngle = CGFloat(Double.pi)
                        case 3*CGFloat(Double.pi)/2:
                            center = CGPoint(x: center.x, y: center.y + radius/2)
                            endAngle = 2*CGFloat(Double.pi)
                        default:
                            center = CGPoint(x:bounds.width/3, y: bounds.height/3)
                        }
                        
                        radius = 1.5 * radius
                        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: true)
                        path.lineWidth = 30.0
                        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
                        colorBlueArray[Int(CGFloat(colorBlueArray.count).arc4random)].setStroke()
                        path.stroke()
                        
                    }
                    ccw = true
                }
                
                
                stepper -= 5
            }
            
        }
        
    }
    
    func drawFireworks(_ step: Int) {
        var path = UIBezierPath()
        var root = CGPoint(x: bounds.width / 2, y: bounds.height - bounds.height * 0.1)
        root = CGPoint(x: root.x, y: root.y - bounds.height * 0.4 + (root.y - bounds.height * 0.4) * 0.01)
        path.move(to: root)
        path.lineWidth = 30.0
        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
        colorBlueArray[Int(CGFloat(colorBlueArray.count).arc4random)].setStroke()
        let fireworkArray = makeFireworkArray(root.x, root.y)
        var fireworkIndex = 0
        let startPointArray = [root, CGPoint(x: root.x * 1.025, y: root.y - root.y * 0.05), CGPoint(x: root.x + root.x * 0.1, y: root.y - root.y * 0.05), CGPoint(x: root.x + root.x * 0.1, y: root.y + root.y * 0.025), CGPoint(x: root.x + root.x * 0.05, y: root.y + root.y * 0.05), root]
        
        for index in 0..<min(25, step) {
            let array = getFireworkStepArray(startPointArray[fireworkIndex], fireworkArray[fireworkIndex])
            path.addLine(to: array[index % 5])
            path.stroke()
            if index % 5 == 4 {
                fireworkIndex += 1
                path = UIBezierPath()
                path.move(to: startPointArray[fireworkIndex])
                colorBlueArray[Int(CGFloat(colorBlueArray.count).arc4random)].setStroke()
                path.lineWidth = 30.0
                path.stroke(with: CGBlendMode.normal, alpha: 0.30)
            }
            
        }
        
        
    }
    
    func redraw() {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func randomNumberBetweenRange(_ numberStart: CGFloat, _ numberEnd: CGFloat) -> CGFloat {
        var randNum = CGFloat(0)
        while true {
            randNum = numberEnd.arc4random
            if randNum >= numberStart {
                break
            }
        }
        return randNum
    }
    
    func makeMidPoint(_ startPoint: CGPoint, _ endPoint: CGPoint) -> CGPoint {
        return CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
    }
    
    func makeRootArray() -> [CGPoint] {
        let root1 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.6, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
        let root2 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.35, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
        let root3 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.1, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.075)
        let root4 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.1, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.075)
        let root5 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.35, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
        let root6 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.6, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
        let rootArray = [root1, root2, root3, root4, root5, root6]
        return rootArray
    }
    
    func makeLeftBranchArray(_ rootY: CGFloat) -> [CGPoint] {
        let branch1 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.5, y: rootY)
        let branch3 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.95, y: rootY - rootY * 0.1)
        let branch5 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.55, y: rootY - rootY * 0.20)
        let branch7 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.80, y: rootY - rootY * 0.55)
        let branch9 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.325, y: rootY - rootY * 0.3)
        let branch11 = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.50, y: rootY - rootY * 0.65)
        let branchArray = [branch1, branch3, branch5, branch7, branch9, branch11]
        return branchArray
    }
    
    func makeRightBranchArray(_ rootY: CGFloat) -> [CGPoint] {
        let branch2 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.5, y: rootY)
        let branch4 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.95, y: rootY - rootY * 0.1)
        let branch6 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.55, y: rootY - rootY * 0.20)
        let branch8 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.80, y: rootY - rootY * 0.55)
        let branch10 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.325, y: rootY - rootY * 0.3)
        let branch12 = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.50, y: rootY - rootY * 0.65)
        let branchArray = [branch2, branch4, branch6, branch8, branch10, branch12]
        return branchArray
    }
    
    func makeFireworkArray(_ rootX: CGFloat, _ rootY: CGFloat) -> [CGPoint] {
        let pt1 = CGPoint(x: rootX - rootX * 0.90, y: rootY + rootY * 0.20)
        let pt2 = CGPoint(x: rootX - rootX * 0.65, y: rootY - rootY * 0.65)
        let pt3 = CGPoint(x: rootX + rootX * 0.60, y: rootY - rootY * 0.65)
        let pt4 = CGPoint(x: rootX + rootX * 0.925, y: rootY * 1.30)
        let pt5 = CGPoint(x: rootX - rootX * 0.15, y: rootY * 1.75)
        let ptArray = [pt1, pt2, pt3, pt4, pt5]
        return ptArray
    }
    
    func getFireworkStepArray(_ startingPoint: CGPoint, _ endingPoint: CGPoint) -> [CGPoint] {
        let deltaX = endingPoint.x - startingPoint.x
        let deltaY = endingPoint.y - startingPoint.y
        let deltaXIncrement = deltaX/5
        let deltaYIncrement = deltaY/5
        var xInc = deltaXIncrement
        var yInc = deltaYIncrement
        var fireworkStepArray = [CGPoint]()
        for _ in 0..<5 {
            fireworkStepArray.append(CGPoint(x: startingPoint.x + xInc, y: startingPoint.y + yInc))
            xInc += deltaXIncrement
            yInc += deltaYIncrement
        }
        return fireworkStepArray
    }
    
}


extension CGFloat {
    var arc4random: CGFloat {
        if self > 0 {
            return CGFloat(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -CGFloat(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

