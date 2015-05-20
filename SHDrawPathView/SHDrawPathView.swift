//
//  SHDrawPathView.swift
//  SHDrawPathView
//
//  Created by WuShengHua on 5/13/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

public class SHDrawPathView: UIView {

    // MARK: Public property
    public var strokeColor = UIColor.blueColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    public var strokeWidth: CGFloat = 3.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: Private propery
    private let path = UIBezierPath()
    private let tolerance: CGFloat = 10.0
    private let backgroundImageView = UIImageView(frame: CGRectZero)
    
    // MARK: Designated initializer
    public override init(frame: CGRect) {
        self.path.lineCapStyle = kCGLineCapRound
        self.path.lineJoinStyle = kCGLineJoinRound
        self.path.lineWidth = self.strokeWidth
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.backgroundImageView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.path.lineCapStyle = kCGLineCapRound
        self.path.lineJoinStyle = kCGLineJoinRound
        self.path.lineWidth = self.strokeWidth
        
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.backgroundImageView)
    }
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundImageView.frame = self.bounds
        self.renderImageInBackgroundForRect(self.backgroundImageView.frame)
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
        if self.shouldDrawPathToPoint(point) {
            self.path.addLineToPoint(point)
            self.setNeedsLayout()
        }
    }
    
    // MARK: Tolerance
    func shouldDrawPathToPoint(point: CGPoint) -> Bool {
        return self.path.currentPoint.distanceFromPoint(point) >= self.tolerance
    }
    
    // MARK: Render image
    func strokePathInContext(context: CGContextRef) {
        if self.path.empty {
            return
        }
        
        CGContextSaveGState(context)
        self.strokeColor.setStroke()
        self.path.stroke()
        CGContextRestoreGState(context)
    }
    
    func renderImageForRect(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        
        self.strokePathInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func renderImageInBackgroundForRect(rect: CGRect) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            let image = self.renderImageForRect(rect)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.backgroundImageView.image = image
            })
        }
    }
    
}

// MARK: Calculate distance
extension CGPoint {
    
    func distanceFromPoint(point: CGPoint) -> CGFloat {
        let x = self.x - point.x
        let y = self.y - point.y
        
        return sqrt(x * x + y * y)
    }
    
}
