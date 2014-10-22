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

let kAlbumCellIdentifier = "kAlbumCellIdentifier"

class AlbumTableViewCellFactory: NSObject, BSTableViewCellFactory {
    
    class func registerCellIdentifiersForTableView(aTableView: UITableView!) {
        aTableView.registerClass(AlbumCell.self, forCellReuseIdentifier: kAlbumCellIdentifier)
    }
    
    class func heightAtIndexPath(anIndexPath: NSIndexPath!, forModel aModel: BSItemsModel!) -> CGFloat {
        if let assetsGroup = aModel.itemAtIndexPath(anIndexPath) as? ALAssetsGroup {
            let thumbSize = CGSizeMake(CGFloat(CGImageGetWidth(assetsGroup.posterImage().takeUnretainedValue())), CGFloat(CGImageGetHeight(assetsGroup.posterImage().takeUnretainedValue())))
            
            //We want 3 images in each row. So width should be viewWidth-(4*LEFT/RIGHT_INSET)/3
            //4*2.0 is edgeinset
            //Height should be adapted so we maintain the aspect ratio of thumbnail
            //original height / original width * new width
            var itemSize = CGSizeMake((320-(4*2))/3, 100)
            itemSize = CGSizeMake(itemSize.width, thumbSize.height/thumbSize.height * itemSize.width)
            
            return itemSize.height
        } else {
            return 44
        }
    }
    
    func cellAtIndexPath(anIndexPath: NSIndexPath!, forTableView aTableView: UITableView!, withModel aModel: BSItemsModel!) -> UITableViewCell! {
        if let albumCell = aTableView.dequeueReusableCellWithIdentifier(kAlbumCellIdentifier) as? AlbumCell {
            
            if let assetGroup = aModel.itemAtIndexPath(anIndexPath) as? ALAssetsGroup {
                albumCell.imageView.image = UIImage(CGImage: assetGroup.posterImage().takeUnretainedValue())
                albumCell.textLabel.text = assetGroup.valueForProperty(ALAssetsGroupPropertyName) as? String
                albumCell.backgroundColor = UIColor.clearColor()
                albumCell.selectionStyle = .None
                
                //Reset
                albumCell.secondImageView.image = nil
                albumCell.thirdImageView.image = nil
                
                assetGroup.enumerateAssetsWithOptions(.Reverse, usingBlock: { (asset: ALAsset!, index:  Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                    if asset != nil {
                        if index == 1 {
                            albumCell.secondImageView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
                            stop.memory = false
                        } else if index == 2 {
                            albumCell.thirdImageView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
                        }
                    }
                })
            }
            
            return albumCell
        }
        
        assert(false, "Unknown cell type")
    }
}
