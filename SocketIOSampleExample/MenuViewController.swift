//
//  MenuViewController.swift
//  SocketIOSampleExample
//
//  Created by Alim Yıldız on 4/12/22.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var membersRegisterTxtField: UITextField!
    @IBOutlet weak var FirstMember: UILabel!
    @IBOutlet weak var SecondMember: UILabel!
    @IBOutlet weak var ThirtMember: UILabel!
    
    @IBOutlet weak var FirstMemberMessage: UILabel!
    @IBOutlet weak var SecondMemberMessage: UILabel!
    @IBOutlet weak var ThirdMemberMessage: UILabel!
    
    var memberArray = [String]()
    
    
    //Socek connection
    var mSocket = SocketChatManager.sharedInstance.getSocket()
    var user: User!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketChatManager.sharedInstance.establisConnection()
        
        SocketChatManager.sharedInstance.onConnect {
           // self.registerUser()
            
            SocketChatManager.sharedInstance.joinRoom(userName: "Ali Yıldız", roomName:"android")

        }
        
        SocketChatManager.sharedInstance.onJoinRoom()
        SocketChatManager.sharedInstance.onMessage()
        SocketChatManager.sharedInstance.onMessageTyping()
    }
    
    func registerUser() {
        self.user = User(sessionId: SocketChatManager.sharedInstance.mSocket.sid!, username: "Alim Yıldız")
        SocketChatManager.sharedInstance.register(user: user)
    }
    
    

    @IBAction func addMemberAction(_ sender: Any) {
        
        SocketChatManager.sharedInstance.userMessageTyping()
        SocketChatManager.sharedInstance.sendMessage(messageText: membersRegisterTxtField.text)
    }

}
