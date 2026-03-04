//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 03.03.2026..
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var numberOfPegs: Int
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = [Code]()
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow], numberOfPegs: Int = Int.random(in: 3...6)) {
        self.numberOfPegs = numberOfPegs
        self.pegChoices = pegChoices
        masterCode = Code(kind: .master, numberOfPegs: numberOfPegs)
        guess = Code(kind: .guess, numberOfPegs: numberOfPegs)
        masterCode.randomize(from: pegChoices)
    }
    
    mutating func restartGame() {
        let newNumberOfPegs = Int.random(in: 3...6)
        numberOfPegs = newNumberOfPegs
        masterCode = Code(kind: .master, numberOfPegs: newNumberOfPegs)
        masterCode.randomize(from: pegChoices)
        guess = Code(kind: .guess, numberOfPegs: newNumberOfPegs)
        attempts.removeAll()
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        for pastAttempt in attempts {
            if pastAttempt.pegs == attempt.pegs {
                return
            }
        }
        for peg in guess.pegs {
            if peg == Code.missing {
                return
            }
        }
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
        
    }

}

struct Code: Equatable {
    var kind: Kind
    var pegs: [Peg]
    
    static let missing: Peg = .clear
    
    init(kind: Kind, numberOfPegs: Int) {
        self.kind = kind
        self.pegs = Array(repeating: Code.missing, count: numberOfPegs)
    }
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches):
            return matches
        default:
            return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}

