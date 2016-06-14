//
//  XNHeadView.swift
//  Swift-willSet
//
//  Created by xuning on 16/6/14.
//  Copyright © 2016年 hus. All rights reserved.
//

import UIKit

class XNHeadView: UIView {
    
     private var head: UIView?
    
    var tableHeadViewHeight: CGFloat = 0 {
        willSet {
            NSNotificationCenter.defaultCenter().postNotificationName(HomeTableHeadViewHeightDidChange, object: newValue)
            frame = CGRectMake(0, -newValue, ScreenWidth, newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        head = UIView()
        head!.frame = CGRectMake(0, 0, ScreenWidth, 200)
        
        head?.backgroundColor = UIColor.redColor()
        addSubview(head!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        tableHeadViewHeight = CGRectGetMaxY(head!.frame)
    }

}
