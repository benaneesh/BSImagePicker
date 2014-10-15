//
//  PhotoCell.swift
//  BSImagePicker
//
//  Created by Joakim Gyllström on 2014-10-15.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        var lazyImageView = UIImageView(frame: self.contentView.bounds)
        lazyImageView.contentMode = .ScaleAspectFill
        lazyImageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        
        return lazyImageView
    }()
    
    lazy var fadedCoverView: UIView = {
        var lazyCoverView = UIView(frame: self.contentView.bounds)
        lazyCoverView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        lazyCoverView.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        
        return lazyCoverView
    }()
    
    lazy var checkmarkView: NumberedSelectionView = {
        var lazyCheckmarkView = NumberedSelectionView(frame: CGRectMake(self.imageView.bounds.size.width-25.0, self.imageView.bounds.size.height-25.0, 25.0, 25.0))
        lazyCheckmarkView.contentMode = .Redraw
        lazyCheckmarkView.autoresizingMask = .FlexibleLeftMargin | .FlexibleTopMargin
        lazyCheckmarkView.backgroundColor = UIColor.clearColor()
        
        return lazyCheckmarkView
    }()
    
    func setPictureNumber(aNumber: Int, selected: Bool, animated: Bool) {
        super.selected = selected
        
        fadedCoverView.hidden = !selected
        checkmarkView.pictureNumber = aNumber
        checkmarkView.hidden = !selected
        
        if animated {
            UIView.animateWithDuration(0.08, animations: { () -> Void in
                self.imageView.transform = CGAffineTransformMakeScale(0.95, 0.95)
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(0.08, animations: { () -> Void in
                    self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(fadedCoverView)
        imageView.addSubview(checkmarkView)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
