//
//  PrimaryTextView.swift
//  ReusableComponents
//
//  Created by Alexander Snitko on 10.11.21.
//

import UIKit

@IBDesignable
class PrimaryTextView: UIView {
    
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero)
    var textField: UITextField = UITextField(frame: CGRect.zero)
//    var floatingLabel: UILabel
    
    
    @IBInspectable
    var superviewBackgoundColor: UIColor = UIColor.gray {
        didSet {
            self.backgroundColor = superviewBackgoundColor
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var floatingLabelHeight: CGFloat = 17
    @IBInspectable
    var textFieldHeight: CGFloat = 22
    
    @IBInspectable
    var textFieldPlaceholder: String? {
        didSet {
            self.textField.placeholder = textFieldPlaceholder
        }
    }
    
    
    
    
    
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.textField.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textFieldPlaceholder = (self.textFieldPlaceholder != nil) ? self.textFieldPlaceholder : textField.placeholder
        self.textField.placeholder = self.textFieldPlaceholder
        
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.textField = UITextField(frame: CGRect(x: 16, y: (self.frame.size.height - self.textFieldHeight) / 2, width: self.frame.size.width - 32, height: self.textFieldHeight))
        self.addSubview(textField)
        
        self.textField.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    @objc private func addFloatingLabel() {
//        if self.text == "" {
//            self.floatingLabel.textColor = self.floatingLabelColor
//            self.floatingLabel.font = self.floatingLabelFont
//            self.floatingLabel.text = self.textFieldPlaceholder
//            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
//            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
//            self.floatingLabel.clipsToBounds = true
//            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
//
//            self.layer.borderColor = self.activeBorderColor.cgColor
//            self.addSubview(floatingLabel)
//
//            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
//
//            self.placeholder = ""
//        }
//        self.setNeedsDisplay()
    }
    
    @objc private func removeFloatingLabel() {
//        if self.text == "" {
//            UIView.animate(withDuration: 0.13) {
//                self.subviews.forEach( { $0.removeFromSuperview() } )
//                self.setNeedsDisplay()
//            }
//            self.placeholder = self._placeholder
//        }
//        self.layer.borderColor = UIColor.black.cgColor
//    }
    
    }
}
