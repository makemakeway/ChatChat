//
//  ChatViewController.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/13.
//

import UIKit

class ChatViewController: UIViewController {
    //MARK: Properties
    
    
    
    //MARK: UI
    
    let mainView = ChatView()
    
    //MARK: Method
    
    func tableViewConfig() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(YourMessageTableViewCell.self, forCellReuseIdentifier: YourMessageTableViewCell.reuseIdentifier)
        mainView.tableView.register(MyMessageTableViewCell.self, forCellReuseIdentifier: MyMessageTableViewCell.reuseIdentifier)
    }
    
    func navBarConfig() {
        self.navigationController?.navigationBar.backgroundColor = .darkGray
    }
    
    
    //MARK: LifeCycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        navBarConfig()
    }
    
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let yourCell = tableView.dequeueReusableCell(withIdentifier: YourMessageTableViewCell.reuseIdentifier, for: indexPath) as? YourMessageTableViewCell else { return UITableViewCell() }
        
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.reuseIdentifier, for: indexPath) as? MyMessageTableViewCell else { return UITableViewCell() }
        
        yourCell.messageLabel.text = "따른 사람이 보내는 메세지임ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"
        yourCell.messageDateLabel.text = "12/01"
        
        myCell.messageLabel.text = "내가 보낸 메세지임 ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ"
        myCell.messageDateLabel.text = "11.02"
        
        if indexPath.row % 2 == 0 {
            return yourCell
        } else {
            return myCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
}
