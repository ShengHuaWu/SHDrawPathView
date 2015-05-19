//
//  ViewController.swift
//  Sample
//
//  Created by WuShengHua on 5/17/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let drawPathView = SHDrawPathView(frame: CGRectZero);

    // MARK: View life cycle
    override func loadView() {
        self.drawPathView.backgroundColor = UIColor.whiteColor()
        self.view = self.drawPathView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(title: "Change Color", style: UIBarButtonItemStyle.Plain, target: self, action: "changeColor")
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    // MARK: Button action
    func changeColor() {
        self.drawPathView.strokeColor = UIColor.redColor()
    }

}

