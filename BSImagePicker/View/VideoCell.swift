//
//  VideoCell.swift
//  BSImagePicker
//
//  Created by Joakim Gyllström on 2014-10-15.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

import UIKit

class VideoCell: BSPhotoCell {
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
