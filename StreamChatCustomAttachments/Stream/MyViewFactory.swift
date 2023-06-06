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
    
    func makeLeadingComposerView(state: Binding<PickerTypeState>, channelConfig: ChannelConfig?) -> some View {
        viewModel.closeAttachments = {
            state.wrappedValue = .expanded(.none)
        }
        return LeadingComposerView(pickerTypeState: state)
    }
    
    func makeCustomAttachmentView(
        addedCustomAttachments: [CustomAttachment],
        onCustomAttachmentTap: @escaping (CustomAttachment) -> Void
    ) -> some View {
        PaymentAttachmentPickerView(viewModel: viewModel)
    }
    
}
