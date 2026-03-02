//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 26.02.2026..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .red, .green, .yellow])
            pegs(colors: [.yellow, .green, .blue, .blue])
        }
        .padding()
    }
    
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .nomatch, .inexact, .exact])
        }
    }
}

#Preview {
    ContentView()
}
