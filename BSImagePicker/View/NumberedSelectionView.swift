// The MIT License (MIT)
//
// Copyright (c) 2014 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class NumberedSelectionView: UIView {
    private var _pictureNumber = 0
    var pictureNumber: Int {
        get {
            return _pictureNumber
        }
        set {
            _pictureNumber = newValue
            setNeedsDisplay()
        }
    }
        
    override func drawRect(rect: CGRect) {
        //// General Declarations
        var context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        var checkmarkBlue2 = tintColor
        
        //// Shadow Declarations
        var shadow2 = UIColor.blackColor()
        var shadow2Offset = CGSizeMake(0.1, -0.1)
        var shadow2BlurRadius: CGFloat = 2.5
        
        //// Frames
        var frame = self.bounds
        
        //// Subframes
        var group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6)
        
        //// CheckedOval Drawing
        var checkedOvalPath = UIBezierPath(ovalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5)))
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor)
        checkmarkBlue2.setFill()
        checkedOvalPath.fill()
        CGContextRestoreGState(context)
        
        UIColor.whiteColor().setStroke()
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()
        
        //// Bezier Drawing (Picture Number)
        if (_pictureNumber > 0) {
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            var text = "\(_pictureNumber)"
            var font = UIFont.boldSystemFontOfSize(13.0)
            var attributes: NSDictionary = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]
            var size = text.sizeWithAttributes(attributes)
            var drawRect = CGRectMake(CGRectGetMidX(frame) - size.width / 2.0,
                CGRectGetMidY(frame) - size.height / 2.0,
                size.width,
                size.height)
            text.drawInRect(drawRect, withAttributes: attributes)
        }
    }
}
