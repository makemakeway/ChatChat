//
//  SocketIOManager.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTZlYmUzNDViZDllZDBjN2NmOSIsImlhdCI6MTY0MjEyMDU1OCwiZXhwIjoxNjQyMjA2OTU4fQ.05SPm7PKS3ci4PrXDuhSeCWUN6NRAZ9TQuHcVZC0Ep8"
    
    //서버와 메세지를 주고받을 클래스, 소켓을 연결하고 해제하는 기능 등 메인 기능 탑재
    var manager: SocketManager!
    
    //
    var socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: "http://test.monocoding.com:1233")!, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth":token])
        ])
        
        self.socket = manager.defaultSocket // "/"로 된 룸
        
        super.init()
        
        // 소켓 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket Connected", data, ack)
        }
        
        // 소켓 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket Disconnected", data, ack)
        }
        
        // 소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        // 데이터 수신 -> 디코딩 -> 모델 추가 -> 갱신
        
        /*
         data
         [{
             "__v" = 0;
             "_id" = 61e0d7f4be345bd9ed0c828b;
             createdAt = "2022-01-14T01:55:00.188Z";
             id = 61e0d7f4be345bd9ed0c828b;
             name = Jerry;
             text = "\Ucc44\Ud305\Ucc44\Ud305";
             updatedAt = "2022-01-14T01:55:00.188Z";
             userId = 61e0c5b1be345bd9ed0c7d2e;
             username = jerry;
         }]
         */
        
        socket.on("sesac") { dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let date = data["createdAt"] as! String
            
            print("SESAC RECEIVED \(chat), \(name), \(date)")
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat":chat, "name":name, "createdAt":date])
        }
        
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
