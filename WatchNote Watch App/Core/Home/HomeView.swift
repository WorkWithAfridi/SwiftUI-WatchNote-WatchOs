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
    
    func getDocumentDirectory()-> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        //        dump(notes)
        do{
            let data = try JSONEncoder().encode(notes)
            
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            try data.write(to: url)
        } catch {
            print("DEBUG: ERROR SAVING DATA IN SAVE FUNC.")
        }
    }
    
    func getNotes(){
        DispatchQueue.main.async {
            do{
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([NoteModel].self, from: data)
            } catch {
                print("DEBUG: NO DATA FOUND IN GET NOTES FUNC.")
            }
        }
    }
    
    func deleteNote (offsets: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 6){
                TextField("Add New Note", text: $textController)
                Button(action: {
                    guard textController.isEmpty == false else {return}
                    
                    let note = NoteModel(id: UUID(), text:textController)
                    
                    notes.append(note)
                    
                    textController = ""
                    save()
                }, label: {
                    Image(systemName: "plus")
                })
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }
            Spacer()
            if notes.count >= 1 {
                List{
                    ForEach(notes) {
                        note in
                        HStack{
                            Capsule()
                                .frame(width: 4)
                                .foregroundColor(.accentColor)
                            Text(note.text)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        }
                    }
                    .onDelete { offset in
                        deleteNote(offsets: offset)
                    }
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }
        }
        .navigationTitle("WatchNote")
        .onAppear {
            getNotes()
        }
    }
}

#Preview {
    HomeView()
}
