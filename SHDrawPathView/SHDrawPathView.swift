//
//  SHDrawPathView.swift
//  SHDrawPathView
//
//  Created by WuShengHua on 5/13/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

public class SHDrawPathView: UIView {

    private let path: UIBezierPath = UIBezierPath()
    
    // MARK: Designated initializer
    public override init(frame: CGRect) {
        self.path.lineCapStyle = kCGLineCapRound
        self.path.lineJoinStyle = kCGLineJoinRound
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.path.lineCapStyle = kCGLineCapRound
        self.path.lineJoinStyle = kCGLineJoinRound
        
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: Draw rect
    public override func drawRect(rect: CGRect) {
        UIColor.blueColor().setStroke()
        self.path.stroke()
    }
    
    // MARK: Touch events
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch: UITouch = touches.first as! UITouch
        let point = touch.locationInView(self)
        self.path.moveToPoint(point)
    }
    
    public override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch: UITouch = touches.first as! UITouch
        let point = touch.locationInView(self)
        self.path.addLineToPoint(point)
        self.setNeedsDisplay()
    }
    
}
