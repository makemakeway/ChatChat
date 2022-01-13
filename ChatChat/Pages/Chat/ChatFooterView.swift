//
//  ChatFooterView.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import UIKit
import SnapKit

class ChatFooterView: UIView, ViewRepresentable {
    let messageTextField = UITextField()
    
    func setUpView() {
        self.backgroundColor = .darkGray
        
        addSubview(messageTextField)
        messageTextField.borderStyle = .none
        messageTextField.backgroundColor = .lightGray
        messageTextField.layer.borderColor = UIColor.darkGray.cgColor
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.cornerRadius = 20
    }
    
    func setUpConstraints() {
        messageTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
