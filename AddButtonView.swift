//
//  AddButtonView.swift
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 6/29/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

import UIKit

class AddButtonView: UIButton {

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().setFill()
        path.fill()
        
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width,bounds.height) * 0.6
        
        //create path
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        
        plusPath.moveToPoint(CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5,y:bounds.height/2 + 0.5))
        
        plusPath.addLineToPoint(CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        UIColor.whiteColor().setStroke()
        
        plusPath.moveToPoint(CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 - plusWidth/2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 + plusWidth/2 + 0.5))
        
        plusPath.stroke()
        
    }

}
