//
//  NoteModel.swift
//  WatchNote Watch App
//
//  Created by Khondakar Afridi on 1/12/24.
//

import Foundation

struct NoteModel : Identifiable, Codable{
    let id: UUID
    let text: String
}
