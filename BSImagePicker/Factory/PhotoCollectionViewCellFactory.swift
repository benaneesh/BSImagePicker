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

let kPhotoCellIdentifier =             "photoCellIdentifier";
let kVideoCellIdentifier =             "videoCellIdentifier";

class PhotoCollectionViewCellFactory: NSObject, BSCollectionViewCellFactory {
    
    class func registerCellIdentifiersForCollectionView(aCollectionView: UICollectionView!) {
        aCollectionView.registerClass(PhotoCell.self, forCellWithReuseIdentifier: kPhotoCellIdentifier)
        aCollectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: kVideoCellIdentifier)
    }
    
    class func sizeAtIndexPath(anIndexPath: NSIndexPath!, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGSize {
        
        if let asset = aModel.itemAtIndexPath(anIndexPath) as? ALAsset {
            let thumbnailSize = CGSizeMake(CGFloat(CGImageGetWidth(asset.thumbnail().takeUnretainedValue())), CGFloat(CGImageGetHeight(asset.thumbnail().takeUnretainedValue())))
            
            //We want 3 images in each row. So width should be viewWidth-(4*LEFT/RIGHT_INSET)/3
            //Height should be adapted so we maintain the aspect ratio of thumbnail
            //original height / original width * new width
            let sectionInsets = PhotoCollectionViewCellFactory.edgeInsetAtSection(UInt(anIndexPath.section), forCollectionView: aCollectionView, withModel: aModel)
            let minItemSpacing = PhotoCollectionViewCellFactory.minimumItemSpacingAtSection(UInt(anIndexPath.section), forCollectionView: aCollectionView, withModel: aModel)
            
            var itemSize = CGSizeMake((aCollectionView.bounds.size.width - (sectionInsets.left + 2*minItemSpacing + sectionInsets.right))/3.0, 100)
            itemSize = CGSizeMake(itemSize.width, thumbnailSize.height / thumbnailSize.width * itemSize.width)
            
            return itemSize
        }
        
        return CGSizeZero
    }
    
    class func edgeInsetAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> UIEdgeInsets {
        return UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0)
    }
    
    class func minimumItemSpacingAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGFloat {
        return 2.0
    }
    
    class func minimumLineSpacingAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGFloat {
        return 2.0
    }
    
    func cellAtIndexPath(anIndexPath: NSIndexPath!, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> UICollectionViewCell! {
        if let asset = aModel.itemAtIndexPath(anIndexPath) as? ALAsset {
            switch asset.valueForProperty(ALAssetPropertyType) {
            case ALAssetTypePhoto as NSString:
                if let photoCell = aCollectionView.dequeueReusableCellWithReuseIdentifier(kPhotoCellIdentifier, forIndexPath: anIndexPath) as? PhotoCell {
                    photoCell.imageView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
                    photoCell.setPictureNumber(0, selected: aModel.isItemAtIndexPathSelected(anIndexPath), animated: false)
                    
                    return photoCell
                } else {
                    assert(false, "No photo cell registered")
                }
            case ALAssetTypeVideo as NSString:
                if let videoCell = aCollectionView.dequeueReusableCellWithReuseIdentifier(kVideoCellIdentifier, forIndexPath: anIndexPath) as? VideoCell {
                    let formatter = NSDateFormatter()
                    let date = NSDate(timeIntervalSince1970: asset.valueForProperty(ALAssetPropertyDuration).doubleValue)
                    formatter.dateFormat = "mm:ss"
                    videoCell.durationLabel.text = formatter.stringFromDate(date)
                    videoCell.imageView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
                    videoCell.setPictureNumber(0, selected: aModel.isItemAtIndexPathSelected(anIndexPath), animated: false)
                    
                    return videoCell

                } else {
                    assert(false, "No video cell registered")
                }
            default:
                assert(false, "Unknown asset type")
            }
        }
        
        assert(false, "Unknown item type")
    }
}
