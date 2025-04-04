//
//  FileModel.swift
//  PersonalWebEditor
//
//  Created by jacob simpson on 4/4/25.
//

import SwiftUI

struct CodeFile: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var content: String
}
