//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 26.02.2026..
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View {
    var matches: [Match]
    
    private var numberOfColumns: Int {
        (matches.count + 1) / 2
    }
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(0..<numberOfColumns, id: \.self) { column in
                VStack {
                    let topIndex = column * 2
                    matchMarkers(peg: topIndex)
                    
                    let bottomIndex = column * 2 + 1
                    if bottomIndex < matches.count {
                        matchMarkers(peg: bottomIndex)
                    }
                }
            }
        }
    }
    
    func matchMarkers(peg: Int) -> some View {
        let exactCount: Int = matches.count { $0 == .exact}
        let foundCount: Int = matches.count { $0 != .nomatch}
        
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}


#Preview {
    MatchMarkersPreviewRow(matches: [.nomatch, .exact, .inexact])
    MatchMarkersPreviewRow(matches: [.exact, .inexact, .exact, .inexact])
    MatchMarkersPreviewRow(matches: [.nomatch, .exact, .inexact, .exact, .exact])
    MatchMarkersPreviewRow(matches: [.nomatch, .exact, .inexact, .exact, .inexact, .inexact])
    MatchMarkersPreviewRow(matches: [.exact, .exact, .inexact, .exact, .inexact])
    MatchMarkersPreviewRow(matches: [.nomatch, .exact, .nomatch, .nomatch, .inexact])
}

