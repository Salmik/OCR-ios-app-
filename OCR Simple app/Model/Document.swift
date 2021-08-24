//
//  Document.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import Foundation

struct Document: Hashable {
    
    var name: String
    var imageString: String
    var id: UUID
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.id == rhs.id
    }
    
}
