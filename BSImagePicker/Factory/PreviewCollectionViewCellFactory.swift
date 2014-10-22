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

let kPreviewCellIdentifier =             "previewCellIdentifier"

class PreviewCollectionViewCellFactory: NSObject, BSCollectionViewCellFactory {
    
    class func registerCellIdentifiersForCollectionView(aCollectionView: UICollectionView!) {
        aCollectionView.registerClass(PhotoCell.self, forCellWithReuseIdentifier: kPreviewCellIdentifier)
    }
    
    
    class func sizeAtIndexPath(anIndexPath: NSIndexPath!, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGSize {
        let insets = aCollectionView.contentInset;
        let collectionSize = aCollectionView.bounds.size;
        
        return CGSizeMake(collectionSize.width - (insets.left + insets.right), collectionSize.height - (insets.top + insets.bottom))
    }
    
    class func edgeInsetAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    class func minimumItemSpacingAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGFloat {
        return 0.0
    }
    
    class func minimumLineSpacingAtSection(aSection: UInt, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> CGFloat {
        return 0.0
    }
    
    func cellAtIndexPath(anIndexPath: NSIndexPath!, forCollectionView aCollectionView: UICollectionView!, withModel aModel: BSItemsModel!) -> UICollectionViewCell! {
        if let photoCell = aCollectionView.dequeueReusableCellWithReuseIdentifier(kPreviewCellIdentifier, forIndexPath: anIndexPath) as? PhotoCell {
            if let asset = aModel.itemAtIndexPath(anIndexPath) as? ALAsset {
                photoCell.fadedCoverView.removeFromSuperview()
                photoCell.checkmarkView.removeFromSuperview()
                photoCell.imageView.contentMode = .ScaleAspectFit
                photoCell.imageView.image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
//                photoCell.imageView.image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue(), scale: asset.defaultRepresentation().scale(), orientation: asset.defaultRepresentation().orientation())
                
                return photoCell
            }
        }
        
        assert(false, "Unknown cell or asset class")
    }
}
