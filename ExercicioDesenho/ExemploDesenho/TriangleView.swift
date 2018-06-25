//
//  TriangleView.swift
//  ExemploDesenho
//
//  Created by Pedro Henrique on 14/06/2018.
//  Copyright © 2018 IESB. All rights reserved.
//

import UIKit

@IBDesignable
class TriangleView: UIView {
    
    @IBInspectable
    var strokeColor: UIColor = UIColor.red
    
    @IBInspectable
    var fillColor: UIColor = UIColor.cyan

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 80, y: 50))
        path.addLine(to: CGPoint(x: 140, y: 150))
        path.addLine(to: CGPoint(x: 10, y: 150))
        
        path.close()
        
        strokeColor.setStroke()
        fillColor.setFill()
        
        path.lineWidth = 5
        path.fill()
        path.stroke()
    }

}
