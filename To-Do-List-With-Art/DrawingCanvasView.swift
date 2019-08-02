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
    var ccw: Bool = true
    let colorArray = [UIColor.init(displayP3Red: CGFloat(2.0), green: CGFloat(2.0), blue: (2.0), alpha: CGFloat(1.0))]
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //temporary
        step = 75
        var caseStep = 0
        
        if (step <= 25 && step > 0) {
            caseStep = 1 //Spiral
        } else if (step % 100 <= 75 && step % 100 >= 25) {
            caseStep = 2 //Spiral and Tree
        } else if (step >= 100 && (step % 100 == 0 || step % 100 >= 75)) {
            caseStep = 3 //Firework and Tree
        } else if (step >= 100 && (step % 100 <= 25)) {
            caseStep = 4
        }
        
        switch (caseStep) {
        case 1: drawSpiral(step)
        case 2: drawSpiral(25); drawTree(step % 100 - 25)
        case 3: drawTree(50); drawFireworks(step % 100 - 75)
        case 4: drawFireworks(25); drawSpiral(step % 100)
        default: drawSpiral(1)
        }
    
    }

    func drawTree(_ step: Int) {
        var root = CGPoint(x: bounds.width / 2, y: bounds.height - bounds.height * 0.1)
        var path = UIBezierPath()
        var savedPoint: CGPoint
        
        //ROOT -- 12 steps
        path.move(to: root)
        let rootArray = makeRootArray()
        savedPoint = rootArray[0]
        path.addLine(to: savedPoint)
        path.lineWidth = 9.0
        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
        #colorLiteral(red: 0.913316071, green: 0.7689850926, blue: 0.5155162811, alpha: 1).setStroke()
        path.stroke()
        path.move(to: root)
        savedPoint = rootArray[1]
        path.addLine(to: savedPoint)
        path.stroke()
        path.move(to: root)
        savedPoint = rootArray[2]
        path.addLine(to: savedPoint)
        path.stroke()
        path.move(to: root)
        savedPoint = rootArray[3]
        path.addLine(to: savedPoint)
        path.stroke()
        path.move(to: root)
        savedPoint = rootArray[4]
        path.addLine(to: savedPoint)
        path.stroke()
        path.move(to: root)
        savedPoint = rootArray[5]
        path.addLine(to: savedPoint)
        path.stroke()
        
        //Stem -- 14 steps
        path = UIBezierPath()
        path.move(to: root)
        path.lineWidth = 16.0
        savedPoint = CGPoint(x: root.x, y: root.y - bounds.height * 0.4)
        path.addLine(to: savedPoint)
        path.stroke()
        root = CGPoint(x: root.x, y: root.y - bounds.height * 0.4 + (root.y - bounds.height * 0.4) * 0.01)
        
        
        //Branches: 2 steps to each midway point, 3 pairs of branches --> 24 steps
        path = UIBezierPath()
        path.lineWidth = 10.0
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.5, y: root.y)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.95, y: root.y - root.y * 0.1)
        path.addLine(to: savedPoint)
        path.stroke()
        
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.55, y: root.y - root.y * 0.20)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.80, y: root.y - root.y * 0.55)
        path.addLine(to: savedPoint)
        path.stroke()
        
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.325, y: root.y - root.y * 0.3)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.50, y: root.y - root.y * 0.65)
        path.addLine(to: savedPoint)
        path.stroke()
        
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.325, y: root.y - root.y * 0.3)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.50, y: root.y - root.y * 0.65)
        path.addLine(to: savedPoint)
        path.stroke()
        
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.55, y: root.y - root.y * 0.20)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.80, y: root.y - root.y * 0.55)
        path.addLine(to: savedPoint)
        path.stroke()
        
        path.move(to: root)
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.5, y: root.y)
        path.addLine(to: savedPoint)
        path.stroke()
        
        savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.95, y: root.y - root.y * 0.1)
        path.addLine(to: savedPoint)
        path.stroke()
    }
    
    func drawSpiral(_ step: Int) {
        var stepper = step
        
        for _ in stride(from: 0, to: step + 5, by: 5) {
            var center = CGPoint(x: (bounds.width).arc4random, y: (bounds.height - 100).arc4random)
            var startAngle = 3*CGFloat(Double.pi)/2
            var endAngle = CGFloat(0)
            var radius = randomNumberBetweenRange((bounds.width / 170), (bounds.width / 100)) //Initial radius
            
            // Use UIBezierPath to create the CGPath for the layer
            // The path should be the entire spiral
            
            // Begin arc
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            if stepper > 0 {
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
                    path.lineWidth = 12.0
                    path.stroke(with: CGBlendMode.normal, alpha: 0.30)
                    #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).setStroke()
                    path.stroke()
                    
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
        
        
        //1
        var savedPoint = CGPoint(x: root.x - root.x * 0.90, y: root.y + root.y * 0.20)
        path.addLine(to: savedPoint)
        path.lineWidth = 30.0
        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
        #colorLiteral(red: 0.7458879352, green: 0.9206150174, blue: 0.937274754, alpha: 1).setStroke()
        path.stroke()
        
        //2
        path.move(to: CGPoint(x: root.x * 1.025, y: root.y - root.y * 0.05))
        savedPoint = CGPoint(x: root.x - root.x * 0.65, y: root.y - root.y * 0.65)
        path.addLine(to: savedPoint)
        path.stroke()
        
        //3
        path.move(to: CGPoint(x: root.x + root.x * 0.1, y: root.y - root.y * 0.05))
        savedPoint = CGPoint(x: root.x + root.x * 0.60, y: root.y - root.y * 0.65)
        path.addLine(to: savedPoint)
        path.stroke()
        
        //4
        path.move(to: CGPoint(x: root.x + root.x * 0.1, y: root.y + root.y * 0.025))
        savedPoint = CGPoint(x: root.x + root.x * 0.925, y: root.y * 1.30)
        path.addLine(to: savedPoint)
        path.stroke()
        
        //5
        path.move(to: CGPoint(x: root.x + root.x * 0.05, y: root.y + root.y * 0.05))
        savedPoint = CGPoint(x: root.x - root.x * 0.15, y: root.y * 1.75)
        path.addLine(to: savedPoint)
        path.stroke()
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
    
    func midPoint(_ endPoint: CGPoint) -> CGPoint {
        return CGPoint(x: endPoint.x / 2, y: endPoint.y / 2)
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

