//
//  MatchMarkersPreviewRow.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 02.03.2026..
//

import SwiftUI

struct MatchMarkersPreviewRow: View {
    var matches: [Match]

    var body: some View {
        HStack {
            pegs(count: matches.count)
            MatchMarkers(matches: matches)
        }
        .padding()
    }
    
    private func pegs(count: Int) -> some View {
        ForEach(0..<count, id: \.self) { index in
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.primary)
        }
    }
}



#Preview {
    MatchMarkersPreviewRow(matches: [.exact, .inexact, .exact, .nomatch, .inexact])
}

