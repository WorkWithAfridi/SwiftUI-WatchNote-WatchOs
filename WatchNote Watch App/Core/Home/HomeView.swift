//
//  HomeView.swift
//  WatchNote Watch App
//
//  Created by Khondakar Afridi on 1/12/24.
//

import SwiftUI

struct HomeView: View {
    @State private var notes: [NoteModel] = [NoteModel]()
    @State private var textController: String = ""
    
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 6){
                TextField("Add New Note", text: $textController)
                Button(action: {}, label: {
                    Image(systemName: "plus")
                })
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }
            Spacer()
        }
        .navigationTitle("WatchNote")
    }
}

#Preview {
    HomeView()
}
