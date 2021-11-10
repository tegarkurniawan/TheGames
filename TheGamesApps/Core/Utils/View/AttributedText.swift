//
//  AttributedText.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI

public struct AttributedText: View {
   
    public static var tags: Dictionary<String, (Text) -> (Text)> = [
        
        "h1": { $0.font(.largeTitle) },
        "h2": { $0.font(.title) },
        "h3": { $0.font(.headline) },
        "h4": { $0.font(.subheadline) },
        "h5": { $0.font(.callout) },
        "h6": { $0.font(.caption) },
        
        "i": { $0.italic() },
        "u": { $0.underline() },
        "s": { $0.strikethrough() },
        "b": { $0.fontWeight(.bold) },
        
        "sup": { $0.baselineOffset(10).font(.footnote) },
        "sub": { $0.baselineOffset(-10).font(.footnote) }
    ]
  
    private let text: Text

    public init(_ htmlString: String, tags: Dictionary<String, (Text) -> (Text)>? = nil) {
        let parser = HTML2TextParser(htmlString, availableTags: tags == nil ? AttributedText.tags : tags!)
        parser.parse()
        text = parser.formattedText
    }

    public var body: some View {
        text
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText("This is <b>bold</b> and <i>italic</i> text.")
            .foregroundColor(.blue)
            .font(.title)
            .padding()
    }
}
