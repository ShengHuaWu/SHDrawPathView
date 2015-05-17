//
//  ViewController.swift
//  Sample
//
//  Created by WuShengHua on 5/17/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        let drawPathView = SHDrawPathView(frame: CGRectZero);
        drawPathView.backgroundColor = UIColor.whiteColor()
        self.view = drawPathView
    }

}

