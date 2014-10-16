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

class TableController: UIViewController {
    lazy var tableView: UITableView = {
        var lazyView = UITableView()
        lazyView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        lazyView.separatorStyle = .SingleLine
        lazyView.backgroundColor = UIColor.clearColor()
        lazyView.allowsSelection = true
        lazyView.allowsMultipleSelection = true
        lazyView.delegate = self
        lazyView.dataSource = self
        
        return lazyView
    }()
    
    lazy var tableModel: BSItemsModel = {
        var lazyModel = BSAssetsGroupModel()
        lazyModel.setDelegate(self)
        lazyModel.setupWithParentItem(ALAssetsLibrary())
        
        return lazyModel
    }()
    
    lazy var tableCellFactory: BSTableViewCellFactory = {
        var lazyFactory = BSAlbumTableViewCellFactory()
        
        return lazyFactory
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        BSAlbumTableViewCellFactory.registerCellIdentifiersForTableView(tableView)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
}
