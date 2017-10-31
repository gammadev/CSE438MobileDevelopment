//
//  LineView.swift
//  OscarArias-Lab3
//
//  Created by labuser on 10/2/17.
//  Copyright © 2017 oarias. All rights reserved.
//

import UIKit

class LineView: UIView {
    var theLine:Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    var lines:[Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
    
        for line in lines {
            drawLine(line)
        }
        
        if (theLine != nil) {
            drawLine(theLine!)
        }
    }
    
    func drawLine(_ line: Line) {
        let ends = UIBezierPath()
        let path = createQuadPath(points: line.points)
        
        if line.points.count == 1 {
            path.addArc(withCenter: line.points[0], radius: line.width/2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            line.color.setFill()
            path.fill()
        }
        else {
            ends.addArc(withCenter: line.points[0], radius: line.width/2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            ends.addArc(withCenter: line.points[line.points.count - 1], radius: line.width/2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            line.color.setFill()
            ends.fill()
            path.lineWidth = line.width
            
            line.color.setStroke()
            path.stroke()
        }
    }
}
