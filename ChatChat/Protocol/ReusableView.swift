//
//  ReusableView.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String {
        get
    }
}
