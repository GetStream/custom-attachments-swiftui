//
//  MyChannelListViewModel.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

class MyChannelListViewModel: ChatChannelListViewModel {
    
    @Injected(\.chatClient) var chatClient
    
    func updatePaymentPaid(messageId: MessageId, amount: Int) {
        guard let selectedChannelId = selectedChannel?.id else {
            print("Selected channel ID couldn't be retrieved")
            return
        }
        
        let channelId = ChannelId(type: .messaging, id: selectedChannelId)
        
        let messageController = chatClient.messageController(
            cid: channelId,
            messageId: messageId
        )
        
        let extraData: [String: RawJSON] = [
            "paymentState": .string(PaymentState.done.rawValue),
            "paymentDate": .string(Date().formatted())
        ]
        
        messageController.editMessage(text: "", extraData: extraData)
    }
}
