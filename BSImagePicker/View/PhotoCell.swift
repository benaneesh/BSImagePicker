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
