//
//  PaymentAttachmentPickerView.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI

struct PaymentAttachmentPickerView: View {
    
    @ObservedObject var viewModel: MyChannelListViewModel
    
    @State private var selectedAmount: Int? = nil
    
    var paymentAmounts: [Int] = [
        1, 5, 25, 50
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select amount")
                .font(.title)
                .bold()
                .padding()
            
            HStack {
                ForEach(paymentAmounts.indices, id: \.self) { index in
                    Button {
                        withAnimation {
                            selectedAmount = paymentAmounts[index]
                        }
                    } label: {
                        Text("\(paymentAmounts[index])$")
                            .foregroundColor(paymentAmounts[index] == selectedAmount ? .white : .primary)
                            .padding()
                            .background(
                                paymentAmounts[index] == selectedAmount ? LinearGradient.payment : LinearGradient.clear,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke(LinearGradient.payment, lineWidth: 2)
                            }
                        
                    }
                    
                    if index < paymentAmounts.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding()
            
            HStack {
                Spacer()
                
                Button {
                    guard let selectedAmount else { return }
                    
                    viewModel.requestPayment(amount: selectedAmount)
                } label: {
                    Text("Request")
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedAmount == nil)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct PaymentAttachmentPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAttachmentPickerView(viewModel: MyChannelListViewModel())
    }
}
