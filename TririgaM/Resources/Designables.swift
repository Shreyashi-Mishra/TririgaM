//
//  Designables.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import Foundation
import UIKit

// UIView Corner Radios Designable
@IBDesignable
class CRView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskBounds
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            
            let sub_layer = layer
            sub_layer.shadowOpacity = 0.5
            sub_layer.shadowColor = shadowColor.cgColor
            sub_layer.shadowOffset = CGSize.zero
            sub_layer.shadowRadius = 5.5
        }
    }
    
    @IBInspectable var circleRadius: Bool = false

    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamic radius...
        if circleRadius == true {
            layer.cornerRadius = frame.size.height / 2
        }
    }
}


@IBDesignable
class CRGView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskBounds
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            
            let sub_layer = layer
            sub_layer.shadowOpacity = 0.5
            sub_layer.shadowColor = shadowColor.cgColor
            sub_layer.shadowOffset = CGSize.zero
            sub_layer.shadowRadius = 5.5
        }
    }
    
    @IBInspectable var circleRadius: Bool = false
    
    // gradient Colors...
    private var gradientLayer: CAGradientLayer!
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    @IBInspectable var startPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    @IBInspectable var endPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamic radius...
        if circleRadius == true {
            layer.cornerRadius = frame.size.height / 2
        }
        gradientColors()
    }
    
    func gradientColors() {
        
        self.gradientLayer = self.layer as? CAGradientLayer
        self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        self.gradientLayer.startPoint = CGPoint.init(x: startPoint.x, y: startPoint.y)
        self.gradientLayer.endPoint = CGPoint.init(x: endPoint.x, y: endPoint.y)
    }
}


// UIImageView Corner Radios Designable
@IBDesignable
class CRImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskBounds
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var circleRadius: Bool = false
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamic radius...
        if circleRadius == true {
            layer.cornerRadius = frame.size.height / 2
        }
    }
}


// UIButton Corner Radios Designable
@IBDesignable
class CRButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskBounds
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var circleRadius: Bool = false
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamic radius...
        if circleRadius == true {
            layer.cornerRadius = frame.size.height / 2
        }
    }
}

// UIButton Corner Radios Designable
@IBDesignable
class CRLable: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            layer.masksToBounds = maskBounds
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var circleRadius: Bool = false
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamic radius...
        if circleRadius == true {
            layer.cornerRadius = frame.size.height / 2
        }
    }
}
