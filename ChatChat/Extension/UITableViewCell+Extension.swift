//
//  UITableViewCell+Extension.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import UIKit

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
