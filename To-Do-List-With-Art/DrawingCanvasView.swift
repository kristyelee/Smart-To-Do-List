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
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //temporary
        step = 75
        
        if step <= 75 {
            var root = CGPoint(x: bounds.width / 2, y: bounds.height - bounds.height * 0.1)
            var path = UIBezierPath()
            path.move(to: root)
            var savedPoint: CGPoint
            
            //ROOT -- 12 steps
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.6, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
            path.addLine(to: savedPoint)
            path.lineWidth = 9.0
            path.stroke(with: CGBlendMode.normal, alpha: 0.30)
            #colorLiteral(red: 0.5255207419, green: 0.3507483006, blue: 0.05954154581, alpha: 1).setStroke()
            path.stroke()
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.35, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
            path.addLine(to: savedPoint)
            path.stroke()
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.1, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.075)
            path.addLine(to: savedPoint)
            path.stroke()
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.1, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.075)
            path.addLine(to: savedPoint)
            path.stroke()
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.35, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
            path.addLine(to: savedPoint)
            path.stroke()
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 + bounds.width / 2 * 0.6, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
            path.addLine(to: savedPoint)
            path.stroke()
            
            //Stem -- 8 steps
            path = UIBezierPath()
            path.move(to: root)
            path.lineWidth = 16.0
            savedPoint = CGPoint(x: root.x, y: root.y - bounds.height * 0.4)
            path.addLine(to: savedPoint)
            path.stroke()
            root = CGPoint(x: root.x, y: root.y - bounds.height * 0.4 + (root.y - bounds.height * 0.4) * 0.01)
            
            
            //Branches: 4 steps to each midway point, 6 branches --> 48 steps
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
            
            
            step = 25
        }
        
        

        if step <= 25 {
            var stepper = step

            for _ in stride(from: 0, to: step + 5, by: 5) {
                var center = CGPoint(x: (bounds.width).arc4random, y: (bounds.height - 100).arc4random)
                var startAngle = 3*CGFloat(Double.pi)/2
                var endAngle = CGFloat(0)
                var radius = (bounds.width / 60).arc4random //Initial radius
                
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
                        path.lineWidth = 6.0
                        path.stroke(with: CGBlendMode.normal, alpha: 0.30)
                        #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).setStroke()
                        path.stroke()
                        
                    }
                    
                    stepper -= 5
                }
    
            }
            
            // Setup the CAShapeLayer with the path, line width and stroke color
//            linePath.lineWidth = 6.0
//            UIColor.black.setStroke()
//            linePath.stroke()
            
            
        }
        
//        spiralShape1.position = center
//        spiralShape1.path = linePath.cgPath
//        spiralShape1.lineWidth = 6.0
//        spiralShape1.strokeColor = UIColor.yellow.cgColor
//        spiralShape1.fillColor = UIColor.clear.cgColor
        
    
    }
 
//    let path = UIBezierPath()
//    path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//    path.lineWidth = 5.0
//    UIColor.green.setFill()
//    UIColor.red.setStroke()
//    path.stroke()
//    path.fill()
    
    
    func redraw() {
        setNeedsDisplay()
        setNeedsLayout()
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

