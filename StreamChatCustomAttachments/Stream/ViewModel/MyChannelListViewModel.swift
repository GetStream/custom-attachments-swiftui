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
    
    @Published var selectedCustomAttachment: SelectedCustomAttachment = .payment
    
    var onPickerStateChange: ((AttachmentPickerState) -> Void)?
    var closeAttachments: (() -> Void)?
    
    func tryCallingPickerStateChange() {
        if let onPickerStateChange {
            onPickerStateChange(.custom)
        }
    }
    
    func requestPayment(amount: Int) {
        guard let selectedChannelId = selectedChannel?.id else {
            print("Selected channel ID couldn't be retrieved")
            return
        }
        let channelId = ChannelId(type: .messaging, id: selectedChannelId)
        let payloadAttachment = PaymentAttachmentPayload(amount: amount)
        let extraData: [String: RawJSON] = [
            "paymentState": .string(PaymentState.requested.rawValue)
        ]
        
        chatClient.channelController(for: channelId).createNewMessage(
            text: "",
            attachments: [AnyAttachmentPayload(payload: payloadAttachment)],
            extraData: extraData
        )
        
        withAnimation {
            if let closeAttachments {
                closeAttachments()
            }
        }
    }
    
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
