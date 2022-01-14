//
//  ChatViewController.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/13.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ChatViewController: UIViewController {
    //MARK: Properties
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTZlYmUzNDViZDllZDBjN2NmOSIsImlhdCI6MTY0MjEyMDU1OCwiZXhwIjoxNjQyMjA2OTU4fQ.05SPm7PKS3ci4PrXDuhSeCWUN6NRAZ9TQuHcVZC0Ep8"
    
    let username = "yeon"
    
    let url = "http://test.monocoding.com:1233/chats"
    
    var list = [Chat]()
    
    let disposeBag = DisposeBag()
    
    //MARK: UI
    
    let mainView = ChatView()
    
    //MARK: Method
    
    func bind() {
        mainView.footerView.messageTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self](_) in
                guard let self = self else { return }
                if self.mainView.footerView.messageTextField.text!.isEmpty {
                    return
                }
                self.postChat(text: self.mainView.footerView.messageTextField.text!)
                self.mainView.footerView.messageTextField.text = ""
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK: 나중에는 DB에 기록된 마지막 채팅의 시간을 서버에 요청, 서버는 그 이후의 새로운 데이터를 응답
    func requestChats() {
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(token)",
            "Accept" : "application/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: [Chat].self) { response in
            switch response.result {
            case .success(let value):
                SocketIOManager.shared.establishConnection()
                self.list = value
                self.mainView.tableView.reloadData()
                self.mainView.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postChat(text: String) {
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(token)",
            "Accept" : "application/json"
            ]
        
        AF.request(url, method: .post, parameters: ["text":"\(text)"], encoder: JSONParameterEncoder.default, headers: header)
            .responseString { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableViewConfig() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(YourMessageTableViewCell.self, forCellReuseIdentifier: YourMessageTableViewCell.reuseIdentifier)
        mainView.tableView.register(MyMessageTableViewCell.self, forCellReuseIdentifier: MyMessageTableViewCell.reuseIdentifier)
    }
    
    func navBarConfig() {
        self.navigationController?.navigationBar.backgroundColor = .darkGray
    }
    
    @objc func getMessage(notification: NSNotification) {
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let date = notification.userInfo!["createdAt"] as! String
        
        let value = Chat(text: chat, userID: "", name: name, username: "yeon", id: "", createdAt: date, updatedAt: "", v: 0, lottoID: "")
        self.list.append(value)
        self.mainView.tableView.reloadData()
        self.mainView.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    //MARK: LifeCycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        navBarConfig()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        requestChats()
        bind()
        self.title = "새싹채팅"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        let date = DateManager.shared.stringToDate(string: data.createdAt)
        let dateString = DateManager.shared.dateToString(date: date)
        
        if data.username == self.username {
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.reuseIdentifier, for: indexPath) as? MyMessageTableViewCell else { return UITableViewCell() }
            
            myCell.messageLabel.text = data.text
            myCell.messageDateLabel.text = dateString
            
            return myCell
        } else {
            guard let yourCell = tableView.dequeueReusableCell(withIdentifier: YourMessageTableViewCell.reuseIdentifier, for: indexPath) as? YourMessageTableViewCell else { return UITableViewCell() }
            
            yourCell.messageLabel.text = data.text
            yourCell.messageDateLabel.text = dateString
            return yourCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
}
