//
//  FaceView3.swift
//  ExemploDesenho
//
//  Created by Rafael Theodoro on 06/07/2018.
//  Copyright © 2018 IESB. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView3: UIView {
    @IBInspectable
    var strokeColor: UIColor = UIColor.red
    
    private enum Eye {
        case left
        case right
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    override func draw(_ rect: CGRect) {
        strokeColor.setStroke()
        
        //circulo
        pathForSkull().stroke()
        
        //olho esquerdo
        path(forEye: .left).stroke()
        
        //olho direito
        path(forEye: .right).stroke()
        
        //boca
        pathForMouth().stroke()
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * 0.8
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter,
                                radius: skullRadius,
                                startAngle: 0,
                                endAngle: 2 * CGFloat.pi,
                                clockwise: false)
        
        path.lineWidth = 3
        return path
    }
    
    private func path(forEye eye: Eye) -> UIBezierPath {
        
        func centerOf(eye: Eye) -> CGPoint {
            let eyeOffset =
                skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOf(eye: eye)
        
        let path = UIBezierPath(arcCenter: eyeCenter,
                                radius: eyeRadius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: false)
        path.lineWidth = 3
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2,
                               y: skullCenter.y + mouthOffset,
                               width: mouthWidth,
                               height: mouthHeight)
        
        let mouthCurvature = 0.5
        let smileOffset =
            CGFloat(max(-1, min(mouthCurvature, 1))) * mouthHeight
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3,
                          y: start.y + smileOffset)
        
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3,
                          y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end,
                      controlPoint1: cp1,
                      controlPoint2: cp2)
        path.lineWidth = 3
        return path
    }

}
