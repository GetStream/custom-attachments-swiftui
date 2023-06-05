//
//  MyViewFactory.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import Foundation
import StreamChat
import StreamChatSwiftUI

class MyViewFactory: ViewFactory {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
}
