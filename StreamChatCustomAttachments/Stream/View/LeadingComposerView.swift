//
//  LeadingComposerView.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChatSwiftUI

struct LeadingComposerView: View {
    
    @Binding var pickerTypeState: PickerTypeState
    
    @Injected(\.images) var images
    @Injected(\.colors) var colors
    
    var body: some View {
        HStack(spacing: 16) {
            switch pickerTypeState {
            case let .expanded(attachmentPickerType):
                Button {
                    withAnimation {
                        if attachmentPickerType == .custom {
                            pickerTypeState = .expanded(.none)
                        } else {
                            pickerTypeState = .expanded(.custom)
                        }
                    }
                } label: {
                    Image(systemName: "dollarsign.arrow.circlepath")
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 18)
                        .foregroundColor(
                            foregroundColor(for: .custom, selected: attachmentPickerType)
                        )
                }
            case .collapsed:
                Button {
                    withAnimation {
                        pickerTypeState = .expanded(.none)
                    }
                } label: {
                    Image(uiImage: images.shrinkInputArrow)
                        .renderingMode(.template)
                        .foregroundColor(Color(colors.highlightedAccentBackground))
                }
                .accessibilityIdentifier("PickerTypeButtonCollapsed")
            }
        }
        .padding(.bottom, 8)
    }
    
    private func foregroundColor(
        for pickerType: AttachmentPickerType,
        selected: AttachmentPickerType
    ) -> Color {
        if pickerType == selected {
            return Color(colors.highlightedAccentBackground)
        } else {
            return Color(colors.textLowEmphasis)
        }
    }
}

struct LeadingComposerView_Previews: PreviewProvider {
    static var previews: some View {
        LeadingComposerView(pickerTypeState: .constant(.expanded(.custom)))
    }
}
