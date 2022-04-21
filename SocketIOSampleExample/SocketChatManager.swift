//
//  SocketChatManager.swift
//  SocketIOSampleExample
//
//  Created by Alim Yıldız on 4/19/22.
//

import Foundation
import SocketIO

class SocketChatManager {

    // MARK: - Properties
    
     static let sharedInstance = SocketChatManager()
     let socket = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])

    var mSocket:SocketIOClient!

    // MARK: - Life Cycle
    init() {
        mSocket = socket.defaultSocket
    }
    
    func getSocket() -> SocketIOClient {
        return mSocket
    }
    
    func establisConnection() {
        mSocket.connect()
    }
    
    func closeConnection() {
        mSocket.disconnect()
    }
    
    func stop() {
        mSocket?.removeAllHandlers()
    }


    // MARK: - Socket Setup
    func onConnect(handler: @escaping () -> Void) {
        mSocket?.on(clientEvent: .connect) {data, ack in
            print("Connected")
            handler()
        }
    }
    /// #Join chatroom
    func joinRoom(userName: String?, roomName: String?) {
        
        let u: [String: String] = ["userName": userName!, "roomName": roomName!]
        mSocket.emit("joinRoom", u)
    }
    
    /// #Get room and users
    func onJoinRoom() {
        
        mSocket?.on("roomUsers") { (room, users) in
            let userRoom = room
            let userList = users
            print(userRoom)
            print(userList)
        }
    }
    
    /// #this method will send message
    func sendMessage(messageText: String?) {
        mSocket.emit("chatMessage", messageText!)
    }

    /// #Message from server
    func onMessage() {
        mSocket?.on("message") { (data, ack) in
            let msg = data[0] as! [String: Any]
            print(msg["username"])
            print(msg["time"])
            print(msg["text"])
        }
    }

    /// #Socket Room User Typing...
    func userMessageTyping() {
        mSocket.emit("typing")
    }
    
    /// #Socket Room User get typing data value
    func onMessageTyping() {
        mSocket?.on("typing") { (data, ack) in
            let msg = data[0] as! [String: Any]
        }
    }
    

    //Eski method
    func onUserJoined(handler: @escaping () -> Void) {
        mSocket?.on("user joined") { (data, ack) in
            guard let dataInfo = data.first else { return }
            
            handler()
        }
    }
 
    func setupSocketEvents() {

        mSocket?.on("login") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketLogin = try? SocketParser.convert(data: dataInfo) {
                print("Now this chat has \(response.numUsers) users.")
            }*/
        }

        mSocket?.on("user joined") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketUserJoin = try? SocketParser.convert(data: dataInfo) {
                print("User '\(response.username)' joined...")
                print("Now this chat has \(response.numUsers) users.")
            }*/
        }

        mSocket?.on("user left") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketUserLeft = try? SocketParser.convert(data: dataInfo) {
                print("User '\(response.username)' left...")
                print("Now this chat has \(response.numUsers) users.")
            }*/
        }

        mSocket?.on("new message") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketMessage = try? SocketParser.convert(data: dataInfo) {
                print("Message from '\(response.username)': \(response.message)")
            }*/
        }

        mSocket?.on("typing") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
                print("User \(response.username) is typing...")
            }*/
        }

        mSocket?.on("stop typing") { (data, ack) in
            guard let dataInfo = data.first else { return }
           /* if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
                print("User \(response.username) stopped typing...")
            }*/
        }
    }

    // MARK: - Socket Emits
    func register(user: User) {
        let u: [String: String] = ["sessionId": mSocket.sid!, "username": user.username]
        mSocket?.emit("add user", u)
    }

    func send(message: String) {
        mSocket?.emit("new message", message)
    }

}
