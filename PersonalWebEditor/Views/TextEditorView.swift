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
    @State private var testing: String = ""
    
    var body: some View {
        ScrollView(.vertical) {
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
                    HStack(spacing: 0) {
                        TextEditor(text: $testing)
                            .font(.system(.body, design: .monospaced))
                            .frame(maxWidth: 20)
                        
                        TextEditor(text: $files[selectedFileIndex].content)
                            .font(.system(.body, design: .monospaced))
                            .frame(minHeight: 250, maxHeight: 300)
                            .scrollContentBackground(.hidden)
                            .background(Color.black.opacity(0.2))
                            .onChange(of: files[selectedFileIndex].content) {
                                let lineCount = getNumberOfLines(in: files[selectedFileIndex].content)
                                testing = ""
                                
                                if lineCount != 0 {
                                    for i in 1...lineCount {
                                        testing += String(i)
//                                        if i != lineCount {
//                                            testing += "\n\(i)"
//                                        }
                                    }
                                    testing += "\n\(lineCount + 1)"
                                }
                            }
                    }
                } else {
                    Text("Select a file tab to begin editing")
                        .font(.title2)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    private func addNewFile() {
        let newFile = CodeFile(name: "Untitled \(files.count + 1)", content: "Start Editing")
        files.append(newFile)
        selectedFileID = newFile.id
    }
    
    // Function to get the number of lines
    private func getNumberOfLines(in content: String) -> Int {
        return content.split(separator: "\n").count
    }
}

#Preview {
    TextEditorView()
}
