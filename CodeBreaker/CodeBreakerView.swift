//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 26.02.2026..
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
        }
        .padding()
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        } else if color(from: code.pegs[index]) == .clear {
                            
                            Text(code.pegs[index])
                                .font(.system(size: 120))
                                .minimumScaleFactor(9/120)
                        }
                    }
                    .foregroundStyle(color(from: code.pegs[index]))
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }

            let tempMatches = code.matches.isEmpty ? [Match](repeating: .nomatch, count: code.pegs.count) : code.matches
            MatchMarkers(matches: tempMatches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    } else if code.kind == .master {
                        restartButton
                    }
                }
        }
        .padding(.top, 8)
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game.restartGame()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func color(from peg: Peg) -> Color {
        switch peg {
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        case "yellow": return .yellow
        case "purple": return .purple
        case "orange": return .orange
        default: return .clear
        }
    }
}

#Preview {
    CodeBreakerView()
}
