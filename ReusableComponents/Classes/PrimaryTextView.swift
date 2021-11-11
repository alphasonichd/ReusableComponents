//
//  PrimaryTextView.swift
//  ReusableComponents
//
//  Created by Alexander Snitko on 10.11.21.
//

import UIKit

enum TrailingButtonTypes {
    case clear
    case password
}

enum TextFiledTypes {
    case email
    case phone
    case date
    case name
    case surname
    case patronymic
}

@IBDesignable
class PrimaryTextView: UIView {
    
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero)
    var textField: UITextField = UITextField(frame: CGRect.zero)
    var trailingButton: UIButton = UIButton(frame: CGRect.zero)
    var textFieldYConstraint: NSLayoutConstraint!
    var labelYConstraint: NSLayoutConstraint!
    
    var trailingButtonType: TrailingButtonTypes? {
        didSet {
            configureTrailingImage()
        }
    }
    
    var textFieldType: TextFiledTypes?
    
    @IBInspectable
    var trailingButtonImage: UIImage = UIImage()
    
    @IBInspectable
    var viewColor: UIColor = UIColor.gray {
        didSet {
            self.backgroundColor = viewColor
        }
    }
    
    @IBInspectable
    var viewCornerRadius: CGFloat = 16 {
        didSet {
            self.layer.cornerRadius = viewCornerRadius
        }
    }
    
    @IBInspectable
    var labelHeight: CGFloat = 22
    
    @IBInspectable
    var labelColor: UIColor = UIColor.gray {
        didSet {
            self.floatingLabel.textColor = labelColor
        }
    }
    
    @IBInspectable
    var initLabelFont: UIFont = UIFont.systemFont(ofSize: 22) {
        didSet {
            self.floatingLabel.font = self.initLabelFont
        }
    }
    
    @IBInspectable
    var finishedLabelFont: UIFont?
    
    @IBInspectable
    var textFieldHeight: CGFloat = 22
    
    @IBInspectable
    var placeholder: String? {
        didSet {
            self.floatingLabel.text = placeholder
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.clipsToBounds = true
        self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.floatingLabel.clipsToBounds = true
        self.trailingButton.translatesAutoresizingMaskIntoConstraints = false
        self.trailingButton.clipsToBounds = true
        
        self.addSubview(textField)
        self.addSubview(floatingLabel)
        self.addSubview(trailingButton)
        
        self.textFieldYConstraint = self.textField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.labelYConstraint = self.floatingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([
            self.textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.textField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            textFieldYConstraint,
            self.floatingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.floatingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.floatingLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            labelYConstraint
        ])
        
        self.floatingLabel.textColor = self.labelColor
        self.floatingLabel.font = self.initLabelFont
        self.floatingLabel.text = placeholder
        
        self.floatingLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapField)))
        self.floatingLabel.isUserInteractionEnabled = true

        self.textField.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
        
        setNeedsDisplay()
    }
    
    @objc private func didTapField() {
        textField.becomeFirstResponder()
        if textField.text == "" || textField.text == nil {
            NSLayoutConstraint.deactivate([
                self.textFieldYConstraint,
                self.labelYConstraint
            ])
            
            self.textFieldYConstraint = textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
            
            self.labelYConstraint = floatingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7)
            NSLayoutConstraint.activate([
                textFieldYConstraint,
                labelYConstraint
            ])
        }
        
        floatingLabel.animate(font: UIFont.systemFont(ofSize: 13), duration: 0.3)
        UIView.animate(withDuration: 0.3) {
            self.initLabelFont = self.finishedLabelFont ?? UIFont.systemFont(ofSize: 13)
            self.layoutIfNeeded()
        }
    }
    
    
    @objc private func removeFloatingLabel() {
        if self.textField.text == "" || self.textField.text == nil {
            
            NSLayoutConstraint.deactivate([
                self.textFieldYConstraint,
                self.labelYConstraint
            ])
            
            textFieldYConstraint = self.textField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            labelYConstraint = self.floatingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
            NSLayoutConstraint.activate([
                textFieldYConstraint,
                labelYConstraint
            ])
            
            floatingLabel.animate(font: UIFont.systemFont(ofSize: 22), duration: 0.3, aligment: .leading)
        }
        showInvalidData()
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
    }
    
    private func configureTrailingImage() {
        NSLayoutConstraint.activate([
            self.trailingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.trailingButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16),
            self.trailingButton.heightAnchor.constraint(equalToConstant: 12),
            self.trailingButton.widthAnchor.constraint(equalToConstant: 12)
        ])
        self.trailingButton.isHidden = true
        layoutIfNeeded()
    }
    
    private func showInvalidData() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
}

extension UILabel {
    
    enum LabelAligment {
        case leading
        case trailing
        case none
    }
    
    func animate(font: UIFont, duration: TimeInterval, aligment: LabelAligment? = nil) {
        let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        frame.origin = oldFrame.origin // only for left aligned text
        // frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
        setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
