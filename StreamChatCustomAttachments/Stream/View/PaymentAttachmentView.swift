//
//  PaymentAttachmentView.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChat

struct PaymentAttachmentView: View {
    
    @ObservedObject var viewModel: MyChannelListViewModel
    
    var payload: PaymentAttachmentPayload
    var paymentState: PaymentState
    var paymentDate: String?
    var messageId: MessageId
    
    @State private var processing = false
    @State private var processingText = ""
    
    var title: String {
        switch paymentState {
        case .requested:
            return "Payment requested:"
        case .processing:
            return "Processing payment"
        case .done:
            return "Payment done!"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if processing {
                HStack {
                    Spacer()
                    
                    ProgressView()
                        .tint(.white)
                    
                    Spacer()
                }
                
                Text(processingText)
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.top)
            } else {
                Text(title)
                    .font(.headline)
                    .opacity(0.8)
                
                Text("\(payload.amount)$")
                    .font(.system(size: 40, weight: .black, design: .monospaced))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                
                if paymentState == .requested {
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                processingText = "Requesting payment info ..."
                                processing = true
                            }
                            
                            Task {
                                try? await Task.sleep(for: .seconds(1))
                                
                                await MainActor.run {
                                    withAnimation {
                                        processingText = "Finalizing payment ..."
                                    }
                                }
                                
                                try? await Task.sleep(for: .seconds(1))
                                
                                await MainActor.run {
                                    viewModel.updatePaymentPaid(
                                        messageId: messageId,
                                        amount: payload.amount
                                    )
                                }
                            }
                        } label: {
                            Text("Pay")
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(
                                    .ultraThinMaterial,
                                    in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                                )
                            
                        }
                    }
                    .frame(height: 30)
                }
                
                if paymentState == .done, let dateString = paymentDate {
                    HStack {
                        Spacer()
                        
                        Text("Paid: \(dateString)")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .opacity(0.6)
                    }
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, idealHeight: 160, maxHeight: 160)
        .background(
            LinearGradient.payment,
            in: RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
        )
        .padding()
        .shadow(radius: 4)
    }
}

struct PaymentAttachmentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAttachmentView(
            viewModel: MyChannelListViewModel(),
            payload: .preview,
            paymentState: .requested,
            messageId: .init()
        )
        .frame(width: 250)
    }
}
