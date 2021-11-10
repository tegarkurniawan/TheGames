//
//  HTML2TextParser.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI

class HTML2TextParser {
    
    internal private(set) var formattedText = Text("")
   
    private let htmlString: String
   
    private var tags: Set<String> = []
    
    private let availableTags: Dictionary<String, (Text) -> (Text)>

    internal init(_ htmlString: String, availableTags: Dictionary<String, (Text) -> (Text)>) {
        self.htmlString = htmlString
        self.availableTags = availableTags
    }

    internal func parse() {
        var tag: String? = nil
        var endTag: Bool = false
        var startIndex = htmlString.startIndex
        var endIndex = htmlString.startIndex

        for index in htmlString.indices {
            switch htmlString[index] {
            case "<":
                tag = String()
                endIndex = index
                continue

            case "/":
                if index != htmlString.startIndex && htmlString[htmlString.index(before: index)] == "<" {
                    endTag = true
                } else {
                    tag = nil
                }
                continue

            case ">":
                if let tag = tag {
                    addChunkOfText(String(htmlString[startIndex..<endIndex]))
                    if endTag {
                        tags.remove(tag.lowercased())
                        endTag = false
                    } else {
                        tags.insert(tag.lowercased())
                    }
                    startIndex = htmlString.index(after: index)
                }
                tag = nil
                continue

            default:
                break
            }

            if tag != nil {
                if htmlString[index].isLetter || htmlString[index].isHexDigit {
                    tag?.append(htmlString[index])
                } else {
                    tag = nil
                }
            }
        }

        endIndex = htmlString.endIndex
        if startIndex != endIndex {
            addChunkOfText(String(htmlString[startIndex..<endIndex]))
        }
    }

    private func addChunkOfText(_ string: String) {
        guard !string.isEmpty else { return }
        var textChunk = Text(string)

        for tag in tags {
            if let action = availableTags[tag] {
                textChunk = action(textChunk)
            }
        }

        formattedText = formattedText + textChunk
    }
}
