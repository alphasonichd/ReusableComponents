//
//  PrimaryTextField.swift
//  ReusableComponents
//
//  Created by Alexander Snitko on 9.11.21.
//

import UIKit

@IBDesignable
public class PrimaryTextField: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let contentView = Bundle(for: PrimaryTextField.self).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupUI()
    }
    
    func setupUI() {}

}
