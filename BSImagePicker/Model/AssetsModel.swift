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

import Foundation

class AssetsModel: NSObject, BSItemsModel {
    private var assets = [ALAsset]()
    private var selectedAssets = [ALAsset]()
    private var privateDelegate: BSItemsModelDelegate?
    private var assetsGroup: ALAssetsGroup?
    
    func setupWithParentItem(parentItem: AnyObject!) {
        if let parentgroup = parentItem as? ALAssetsGroup {
            assetsGroup = parentgroup
            
            var mutableAssets = [ALAsset]()
            
            //Set up asset filters based on what types of assets the user wants
            let assetType = BSImagePickerSettings.sharedSetting().assetType
            
            if assetType == .Image | .Video {
                parentgroup.setAssetsFilter(ALAssetsFilter.allAssets())
            } else if Bool(assetType.rawValue & BSAssetType.Image.rawValue) {
                parentgroup.setAssetsFilter(ALAssetsFilter.allPhotos())
            } else if Bool(assetType.rawValue & BSAssetType.Video.rawValue) {
                parentgroup.setAssetsFilter(ALAssetsFilter.allVideos())
            } else {
                assert(false, "Unsupported asset type");
            }
            
            parentgroup.enumerateAssetsWithOptions(.Reverse, usingBlock: { (result: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if result != nil {
                    mutableAssets.append(result)
                } else {
                    self.assets = mutableAssets
                    
                    self.privateDelegate?.didUpdateModel(self)
                }
            })
        }
    }
    
    func parentItem() -> AnyObject! {
        return assetsGroup
    }
    
    func setDelegate(delegate: BSItemsModelDelegate!) {
        privateDelegate = delegate
    }
    
    func delegate() -> BSItemsModelDelegate! {
        return privateDelegate
    }
    
    func numberOfSections() -> UInt {
        return assets.count > 0 ? 1:0
    }
    
    func numberOfItemsInSection(aSection: UInt) -> UInt {
        if aSection != 0 {
            return 0
        }
        
        return UInt(assets.count)
    }
    
    func itemAtIndexPath(anIndexPath: NSIndexPath!) -> AnyObject! {
        if anIndexPath.section != 0 || anIndexPath.row >= assets.count {
            return nil
        }
        
        return assets[anIndexPath.row]
    }
    
    func isItemAtIndexPathSelected(anIndexPath: NSIndexPath!) -> Bool {
        if let anObject = itemAtIndexPath(anIndexPath) as? ALAsset {
            return contains(selectedAssets, anObject)
        }
        
        return false
    }
    
    func selectItemAtIndexPath(anIndexPath: NSIndexPath!) {
        if !isItemAtIndexPathSelected(anIndexPath) {
            if let anObject = itemAtIndexPath(anIndexPath) as? ALAsset {
                selectedAssets.append(anObject)
            }
        }
    }
    
    func deselectItemAtIndexPath(anIndexPath: NSIndexPath!) {
        if isItemAtIndexPathSelected(anIndexPath) {
            if let anObject = itemAtIndexPath(anIndexPath) as? ALAsset {
                if let index = find(selectedAssets, anObject) {
                    selectedAssets.removeAtIndex(index)
                }
            }
        }
    }
    
    func clearSelection() {
        selectedAssets.removeAll(keepCapacity: false)
    }
    
    func selectedItems() -> [AnyObject]! {
        var copy = selectedAssets
        return copy
    }
}