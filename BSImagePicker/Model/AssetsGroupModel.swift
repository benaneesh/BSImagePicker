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

class AssetsGroupModel: NSObject, BSItemsModel {
    private var assetsGroups = [ALAssetsGroup]()
    private var privateDelegate: BSItemsModelDelegate?
    private var assetsLibrary: ALAssetsLibrary?
    private var selectedGroup: ALAssetsGroup?
    
    func setupWithParentItem(parentItem: AnyObject!) {
        if let parentgroup = parentItem as? ALAssetsLibrary {
            assetsLibrary = parentgroup
            
            var mutableAssets = [ALAssetsGroup]()
            
            parentgroup.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group: ALAssetsGroup!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if group != nil {
                    if group.valueForProperty(ALAssetsGroupPropertyType).isEqual(NSNumber(unsignedInt: ALAssetsGroupSavedPhotos)) {
                        mutableAssets.insert(group, atIndex: 0)
                    } else {
                        mutableAssets.append(group)
                    }
                } else {
                    //Nil group == the enumeration is done
                    
                    //Default to select first album is no album selected
                    if self.selectedGroup == nil {
                        self.selectedGroup = mutableAssets.first
                    }
                    
                    self.assetsGroups = mutableAssets
                    self.privateDelegate?.didUpdateModel(self)
                }
                }, failureBlock: { (error: NSError!) -> Void in
                    //TODO: HANDLE ERRORS
            })
        }
    }
    
    func parentItem() -> AnyObject! {
        return assetsLibrary
    }
    
    func setDelegate(delegate: BSItemsModelDelegate!) {
        privateDelegate = delegate
    }
    
    func delegate() -> BSItemsModelDelegate! {
        return privateDelegate
    }
    
    func numberOfSections() -> UInt {
        return assetsGroups.count > 0 ? 1:0
    }
    
    func numberOfItemsInSection(aSection: UInt) -> UInt {
        if aSection != 0 {
            return 0
        }
        
        return UInt(assetsGroups.count)
    }
    
    func itemAtIndexPath(anIndexPath: NSIndexPath!) -> AnyObject! {
        if anIndexPath.section != 0 || anIndexPath.row >= assetsGroups.count {
            return nil
        }
        
        return assetsGroups[anIndexPath.row]
    }
    
    func isItemAtIndexPathSelected(anIndexPath: NSIndexPath!) -> Bool {
        if itemAtIndexPath(anIndexPath) != nil && selectedGroup != nil {
            return selectedGroup!.isEqual(itemAtIndexPath(anIndexPath))
        }
        
        return false
    }
    
    func selectItemAtIndexPath(anIndexPath: NSIndexPath!) {
        if !isItemAtIndexPathSelected(anIndexPath) {
            if let anObject = itemAtIndexPath(anIndexPath) as? ALAssetsGroup {
                selectedGroup = anObject
                
                privateDelegate?.didUpdateModel(self)
            }
        }
    }
    
    func deselectItemAtIndexPath(anIndexPath: NSIndexPath!) { }
    
    func clearSelection() { }
    
    func selectedItems() -> [AnyObject]! {
        if selectedGroup == nil {
            return []
        }
        
        return NSArray(object: selectedGroup!)
    }
}
