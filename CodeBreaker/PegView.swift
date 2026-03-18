//
//  PegView.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 16.03.2026..
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    
    // MARK: - Body
    
    let pegShape = RoundedRectangle(cornerRadius: 10)
    
    var body: some View {
        pegShape
            .foregroundStyle(color(from: peg))
            .overlay {
                if peg == Code.missingPeg {
                    pegShape
                        .strokeBorder(Color.gray)
                } else if color(from: peg) == .clear {
                    Text(peg)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9/120)
                }
            }
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
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
    PegView(peg: "blue")
        .padding()
}
