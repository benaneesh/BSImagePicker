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

class VideoCell: PhotoCell {
    lazy var durationLabel: UILabel = {
        var lazyView = UILabel(frame: CGRectMake(5.0, 0.0, self.gradientView.bounds.size.width-10.0, 15.0))
        lazyView.textColor = UIColor.whiteColor()
        lazyView.textAlignment = .Right
        lazyView.font = UIFont.systemFontOfSize(14.0)
        
        return lazyView
    }()
    
    lazy var gradientView: UIView = {
        var lazyView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, 30.0))
        lazyView.autoresizingMask = .FlexibleWidth | .FlexibleBottomMargin
        
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = lazyView.bounds
        gradientLayer.colors = [UIColor(white: 0.0, alpha: 1.0).CGColor, UIColor(white: 0.0, alpha: 0.5).CGColor, UIColor(white: 0.0, alpha: 0.0).CGColor]
        lazyView.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        return lazyView
    }()
    
    private lazy var cameraView: CameraView = {
        var lazyView = CameraView(frame: CGRectMake(5.0, 2.0, 40.0, 10.0))
        lazyView.backgroundColor = UIColor.clearColor()
        lazyView.color = UIColor.whiteColor()
        
        return lazyView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.addSubview(gradientView)
        gradientView.addSubview(durationLabel)
        gradientView.addSubview(cameraView)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
