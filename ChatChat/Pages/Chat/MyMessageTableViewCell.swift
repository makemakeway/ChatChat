//
//  MyMessageTableViewCell.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import UIKit
import SnapKit

class MyMessageTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
    let messageDateLabel = UILabel()
    let messageBubbleView = UIView()
    
    func setUpView() {
        contentView.addSubview(messageBubbleView)
        messageBubbleView.addSubview(messageLabel)
        
        contentView.backgroundColor = .darkGray
        
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        messageLabel.backgroundColor = .gray
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        
        messageBubbleView.backgroundColor = .gray
        messageBubbleView.layer.cornerRadius = 10
        
        contentView.addSubview(messageDateLabel)
        messageDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageDateLabel.textColor = .lightGray
    }
    
    func setUpConstraints() {
        messageBubbleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.7)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        messageDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(messageBubbleView.snp.leading).offset(-10)
            make.centerY.equalTo(messageBubbleView.snp.bottom).offset(-10)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
