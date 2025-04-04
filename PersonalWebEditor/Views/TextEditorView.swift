//
//  TextEditorView.swift
//  PersonalWebEditor
//
//  Created by jacob simpson on 4/4/25.
//

import SwiftUI

struct TextEditorView: View {
    @State private var files: [CodeFile] = [
        CodeFile(name: "Untitled 1", content: "Start Editing")
    ]
    @State private var selectedFileID: UUID?
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(files) { file in
                        Button(action: {
                            selectedFileID = file.id
                        }) {
                            Text(file.name)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(file.id == selectedFileID ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(6)
                        }
                    }
                    Button(action: addNewFile) {
                        Image(systemName: "plus")
                            .padding(.horizontal, 8)
                    }
                }
                .padding(.horizontal)
            }
            if let selectedFileIndex = files.firstIndex(where: {$0.id == selectedFileID}) {
                TextEditor(text: $files[selectedFileIndex].content)
                    .font(.system(.body, design: .monospaced))
                    .background(Color.black.opacity(0.2))
                    .padding()
            } else {
                Text("Select a file tab to begin editing")
                    .font(.title2)
                    .padding()
            }
        }
        .padding()
    }
    
    private func addNewFile() {
        let newFile = CodeFile(name: "Untitled \(files.count + 1)", content: "Start Editing")
        files.append(newFile)
        selectedFileID = newFile.id
    }
}

#Preview {
    TextEditorView()
}
