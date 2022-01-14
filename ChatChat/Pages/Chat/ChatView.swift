//
//  ChatView.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import UIKit
import SnapKit

class ChatView: UIView, ViewRepresentable {

    let tableView = UITableView()
    let footerView = ChatFooterView()
    
    func setUpView() {
        addSubview(tableView)
        addSubview(footerView)
        
        self.backgroundColor = .darkGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .darkGray
    }
    
    func setUpConstraints() {
        footerView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(footerView.snp.top)
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
