//
//  PrimaryButton.swift
//  ReusableComponents
//
//  Created by Alexander Snitko on 8.11.21.
//

import UIKit

public class PrimaryButton: UIButton {
    
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
        
//        setBackgroundColor(.blue, for: .normal)
//        setTitleColor(AppTheme.Colors.white, for: .normal)
//        setBackgroundColor(.red, for: .disabled)
//        setTitleColor(AppTheme.Colors.white, for: .disabled)
    }
}

