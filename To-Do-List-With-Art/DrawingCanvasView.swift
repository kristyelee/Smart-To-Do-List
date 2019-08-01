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
        step = 50
        
        if step <= 50 {
            let root = CGPoint(x: bounds.width / 2, y: bounds.height - bounds.height * 0.1)
            let path = UIBezierPath()
            path.move(to: root)
            var savedPoint: CGPoint
            
            path.move(to: root)
            savedPoint = CGPoint(x: bounds.width / 2 - bounds.width / 2 * 0.6, y: (bounds.height - bounds.height * 0.1) + (bounds.height - bounds.height * 0.1) * 0.05)
            path.addLine(to: savedPoint)
            path.lineWidth = 6.0
            path.stroke(with: CGBlendMode.normal, alpha: 0.30)
            #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1).setStroke()
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
            step = 25
        }
        
        

        if step <= 25 {
            var stepper = step

            for _ in stride(from: 0, to: step + 5, by: 5) {
                var center = CGPoint(x: (bounds.width).arc4random, y: (bounds.height - 100).arc4random)
                var startAngle = 3*CGFloat(Double.pi)/2
                var endAngle = CGFloat(0)
                var radius = (bounds.width / 40).arc4random //Initial radius
                
                // Use UIBezierPath to create the CGPath for the layer
                // The path should be the entire spiral
                
                // Begin arc
                
                let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                
                if stepper > 0 {
                    // 2 - 9 arcs
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

