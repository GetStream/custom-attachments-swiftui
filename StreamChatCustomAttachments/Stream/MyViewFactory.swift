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
    
    func makeLeadingComposerView(
        state: Binding<PickerTypeState>,
        channelConfig: ChannelConfig?
    ) -> some View {
        viewModel.closeAttachments = {
            state.wrappedValue = .expanded(.none)
        }
        return LeadingComposerView(pickerTypeState: state, viewModel: viewModel)
    }
    
    func makeCustomAttachmentView(
        addedCustomAttachments: [CustomAttachment],
        onCustomAttachmentTap: @escaping (CustomAttachment) -> Void
    ) -> some View {
        PaymentAttachmentPickerView(viewModel: viewModel)
    }
    
    func makeCustomAttachmentViewType(
        for message: ChatMessage,
        isFirst: Bool,
        availableWidth: CGFloat,
        scrolledId: Binding<String?>
    ) -> some View {
        let paymentAttachments = message.attachments(payloadType: PaymentAttachmentPayload.self)
        let paymentState = PaymentState(rawValue: message.extraData["paymentState"]?.stringValue ?? "")
        let paymentDate = message.extraData["paymentDate"]?.stringValue

        return VStack {
            ForEach(paymentAttachments.indices, id: \.self) { [weak self] index in
                if let viewModel = self?.viewModel, let paymentState {
                    PaymentAttachmentView(
                        viewModel: viewModel,
                        payload: paymentAttachments[index].payload,
                        paymentState: paymentState,
                        paymentDate: paymentDate,
                        messageId: message.id
                    )
                }
            }
        }
    }
    
    func makeAttachmentSourcePickerView(
        selected: AttachmentPickerState,
        onPickerStateChange: @escaping (AttachmentPickerState) -> Void
    ) -> some View {
        viewModel.onPickerStateChange = onPickerStateChange
        return EmptyView()
    }
    
}
