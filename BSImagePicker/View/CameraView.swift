//
//  CameraView.swift
//  BSImagePicker
//
//  Created by Joakim Gyllström on 2014-10-15.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

import UIKit

class CameraView: UIView {
    var color = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        //Draw it
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 2.84))
        bezierPath.addLineToPoint( CGPointMake(0, 12.84))
        bezierPath.addCurveToPoint( CGPointMake(2, 14.84), controlPoint1: CGPointMake(0, 14.84), controlPoint2: CGPointMake(2, 14.84))
        bezierPath.addLineToPoint( CGPointMake(13.92, 14.84))
        bezierPath.addCurveToPoint( CGPointMake(15.92, 12.84), controlPoint1: CGPointMake(13.92, 14.84), controlPoint2: CGPointMake(15.92, 14.84))
        bezierPath.addLineToPoint( CGPointMake(15.92, 2.84))
        bezierPath.addCurveToPoint( CGPointMake(13.92, 0.84), controlPoint1: CGPointMake(15.92, 0.84), controlPoint2: CGPointMake(13.92, 0.84))
        bezierPath.addLineToPoint( CGPointMake(2, 0.84))
        bezierPath.addCurveToPoint( CGPointMake(0, 2.84), controlPoint1: CGPointMake(2, 0.84), controlPoint2: CGPointMake(0, 0.84))
        bezierPath.closePath()
        bezierPath.moveToPoint( CGPointMake(17.08, 10.97))
        bezierPath.addLineToPoint( CGPointMake(22, 14.84))
        bezierPath.addLineToPoint( CGPointMake(22, 0.84))
        bezierPath.addLineToPoint( CGPointMake(17.08, 4.74))
        bezierPath.addLineToPoint( CGPointMake(17.08, 10.97))
        bezierPath.closePath()
        bezierPath.miterLimit = 4.0
        
        //Scale it (22 and 16 is the original width and height)
        var scale = min(bounds.size.width/22.0, bounds.size.height/16.0);
        bezierPath.applyTransform(CGAffineTransformMakeScale(scale, scale))
        
        //Fill it
        self.color.setFill()
        bezierPath.fill()
    }
}
