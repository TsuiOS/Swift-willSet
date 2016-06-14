//
//  ViewController.swift
//  Swift-willSet
//
//  Created by xuning on 16/6/14.
//  Copyright © 2016年 hus. All rights reserved.
//

import UIKit
public let HomeCollectionViewCellMargin: CGFloat = 10
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height

public let HomeTableHeadViewHeightDidChange = "HomeTableHeadViewHeightDidChange"

private extension Selector {
    
    static let homeTableHeadViewHeightDidChange = #selector(ViewController.homeTableHeadViewHeightDidChange(_:))
    
}

class ViewController: UIViewController {
    
    var headerView: XNHeadView?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        addHomeNotification()
        buildCollectionView()
        buildTableHeaderView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
     NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

extension ViewController {
    
    func addHomeNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .homeTableHeadViewHeightDidChange , name: HomeTableHeadViewHeightDidChange, object: nil)
    }
    
    func buildCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(0, HomeCollectionViewCellMargin, 0, HomeCollectionViewCellMargin)
        ///  设置header区域大小
        layout.headerReferenceSize = CGSizeMake(0, 10)
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "home_cell")
        view.addSubview(collectionView)
        
    }
    func buildTableHeaderView() {
        
        headerView = XNHeadView()
        collectionView.addSubview(headerView!)
        
    }
    
    
    func homeTableHeadViewHeightDidChange(noti: NSNotification) {
        
        collectionView!.contentInset = UIEdgeInsetsMake(noti.object as! CGFloat, 0, 0, 0)
        collectionView!.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)
        
    }

}
// MARK: - UICollectionViewDelegate UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if 0 == section {
            return 6;
        } else if 1 == section {
            return 20
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("home_cell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var itemSize = CGSizeZero
        if 0 == indexPath.section {
            itemSize = CGSizeMake(ScreenWidth - HomeCollectionViewCellMargin * 2, 140)
        } else if indexPath.section == 1 {
            
            itemSize = CGSizeMake((ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, 250)
        }
        
        return itemSize
    }
    

}


extension UIColor {
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
    }
    
    class func colorWithCustom(r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }


}
