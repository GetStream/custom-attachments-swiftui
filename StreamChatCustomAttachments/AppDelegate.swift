//
//  AppDelegate.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // This is a reference to the `StreamChat` object
    var streamChat: StreamChat?
    
    var chatClient: ChatClient = {
        let apiKeyString = "8br4watad788"
        let config = ChatClientConfig(apiKey: .init(apiKeyString))
        let client = ChatClient(config: config)
        return client
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let messageTypeResolver = CustomMessageResolver()
        let utils = Utils(messageTypeResolver: messageTypeResolver)
        streamChat = StreamChat(chatClient: chatClient, utils: utils)
        
        connectUser()
        
        return true
    }
    
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0")
        
        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(id: "luke_skywalker",
                            name: "Luke Skywalker",
                            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
            token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
