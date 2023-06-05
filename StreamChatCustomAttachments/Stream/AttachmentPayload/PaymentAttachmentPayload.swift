//
//  PaymentAttachmentPayload.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import Foundation
import StreamChat

struct PaymentAttachmentPayload: AttachmentPayload, Identifiable {
    static let type: AttachmentType = .payment
    
    var id: String = UUID().uuidString
    var amount: Int
}
