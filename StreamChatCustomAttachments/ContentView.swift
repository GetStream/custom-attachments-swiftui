//
//  ContentView.swift
//  StreamChatCustomAttachments
//
//  Created by Stefan Blos on 05.06.23.
//

import SwiftUI
import StreamChatSwiftUI

struct ContentView: View {
    
    @StateObject private var myChannelListViewModel = MyChannelListViewModel()
    
    var body: some View {
        ChatChannelListView(
            viewFactory: MyViewFactory(viewModel: myChannelListViewModel)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
