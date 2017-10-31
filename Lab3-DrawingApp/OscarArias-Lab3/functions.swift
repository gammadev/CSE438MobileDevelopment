//
//  functions.swift
//  OscarArias-Lab3
//
//  Created by labuser on 10/2/17.
//  Copyright © 2017 oarias. All rights reserved.
//

import UIKit

private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
    // implement this function here
    
    let midx = (first.x + second.x)/2.0
    let midy = (first.y + second.y)/2.0
    
    return CGPoint(x: midx, y: midy)
}

func createQuadPath(points: [CGPoint]) -> UIBezierPath {
    let path = UIBezierPath()
    if points.count < 2 { return path }
    let firstPoint = points[0]
    let secondPoint = points[1]
    let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
    path.move(to: firstPoint)
    path.addLine(to: firstMidpoint)
    for index in 1 ..< points.count-1 {
        let currentPoint = points[index]
        let nextPoint = points[index + 1]
        let midPoint = midpoint(first: currentPoint, second: nextPoint)
        path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
    }
    guard let lastLocation = points.last else { return path }
    path.addLine(to: lastLocation)
    return path
}
