//
//  CustomMessageResolver.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import StreamChat
import StreamChatSwiftUI

class CustomMessageResolver: MessageTypeResolving {
    func hasCustomAttachment(message: ChatMessage) -> Bool {
        let paymentAttachments = message.attachments(payloadType: PaymentAttachmentPayload.self)
        return !paymentAttachments.isEmpty
    }
}
