//
//  PaymentState.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import Foundation

enum PaymentState: String, Codable {
    case requested = "request", processing = "processing", done = "done"
}
