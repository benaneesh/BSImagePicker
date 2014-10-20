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

class AlbumCell: UITableViewCell {
    lazy var secondImageView: UIImageView = {
        var tempImageView = UIImageView()
        tempImageView.layer.shadowColor = UIColor.whiteColor().CGColor
        tempImageView.layer.shadowRadius = 1.0
        tempImageView.layer.shadowOffset = CGSizeMake(0.5, -0.5)
        tempImageView.layer.shadowOpacity = 1.0
        
        return tempImageView
    }()
    
    lazy var thirdImageView: UIImageView = {
        var tempImageView = UIImageView()
        tempImageView.layer.shadowColor = UIColor.whiteColor().CGColor
        tempImageView.layer.shadowRadius = 1.0
        tempImageView.layer.shadowOffset = CGSizeMake(0.5, -0.5)
        tempImageView.layer.shadowOpacity = 1.0
        
        return tempImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageView.superview?.addSubview(secondImageView)
        imageView.superview?.addSubview(thirdImageView)
        imageView.layer.shadowColor = UIColor.whiteColor().CGColor
        imageView.layer.shadowRadius = 1.0
        imageView.layer.shadowOffset = CGSizeMake(0.5, -0.5)
        imageView.layer.shadowOpacity = 1.0
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRectMake(4.0, 10.0, imageView.frame.size.width, contentView.frame.size.height-10.0)
        textLabel.frame = CGRectOffset(imageView.frame, imageView.frame.size.width + 8.0, 0)
        
        secondImageView.layer.zPosition = imageView.layer.zPosition-1
        thirdImageView.layer.zPosition = imageView.layer.zPosition-2
        
        var previousFrame = imageView.frame
        secondImageView.frame = CGRectMake(previousFrame.origin.x+3, previousFrame.origin.y-3, previousFrame.size.width-6, previousFrame.size.height-6)
        previousFrame = secondImageView.frame
        thirdImageView.frame = CGRectMake(previousFrame.origin.x+3, previousFrame.origin.y-3, previousFrame.size.width-6, previousFrame.size.height-6)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            accessoryType = .Checkmark
        } else {
            accessoryType = .None
        }
    }
}