//
//  PrimaryButton.swift
//  ReusableComponents
//
//  Created by Alexander Snitko on 8.11.21.
//

import UIKit

@IBDesignable
public class PrimaryButton: UIButton {
    
    @IBInspectable
    var disabledBackgroundColor: UIColor? {
        set { setBackgroundColor(newValue ?? .black, for: .disabled) }
        get { return self.backgroundColor }
    }
    
    @IBInspectable
    var enabledBackgroundColor: UIColor? {
        set { setBackgroundColor(newValue ?? .black, for: .normal) }
        get { return self.backgroundColor }
    }
    
    @IBInspectable
    var disabledTitleColor: UIColor? {
        set { setTitleColor(newValue, for: .disabled) }
        get { return self.titleColor(for: .disabled) }
    }
    
    @IBInspectable
    var enabledTitleColor: UIColor? {
        set { setTitleColor(newValue, for: .normal) }
        get { return self.titleColor(for: .normal) }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}


