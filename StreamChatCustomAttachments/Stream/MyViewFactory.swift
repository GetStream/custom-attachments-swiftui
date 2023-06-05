//
//  MyViewFactory.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

class MyViewFactory: ViewFactory {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    @ObservedObject var viewModel: MyChannelListViewModel
    
    init(viewModel: MyChannelListViewModel) {
        self.viewModel = viewModel
    }
    
}
