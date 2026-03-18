//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Lora Zubić on 03.03.2026..
//

typealias Peg = String

struct CodeBreaker {
    
    enum GameType {
        case colors
        case emojis
    }

    static let colorPegs = ["red", "green", "blue", "yellow", "purple", "orange"]
    static let emojiPegs = ["🐶","🐱","🐭","🐹","🐰","🦊"]
    
    var gameType: GameType
    var numberOfPegs: Int
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg]
    
    init() {
        gameType = Bool.random() ? .colors : .emojis
        numberOfPegs = Int.random(in: 3...6)
        pegChoices = gameType == .colors ? Array(CodeBreaker.colorPegs.prefix(numberOfPegs)) : Array(CodeBreaker.emojiPegs.prefix(numberOfPegs))
        masterCode = Code(kind: .master(isHidden: true), numberOfPegs: numberOfPegs)
        guess = Code(kind: .guess, numberOfPegs: numberOfPegs)
        masterCode.randomize(from: pegChoices)
    }
    
    mutating func restartGame() {
        gameType = Bool.random() ? .colors : .emojis
        numberOfPegs = Int.random(in: 3...6)
        pegChoices = gameType == .colors ? Array(CodeBreaker.colorPegs.prefix(numberOfPegs)) : Array(CodeBreaker.emojiPegs.prefix(numberOfPegs))
        masterCode = Code(kind: .master(isHidden: true), numberOfPegs: numberOfPegs)
        masterCode.randomize(from: pegChoices)
        guess = Code(kind: .guess, numberOfPegs: numberOfPegs)
        attempts.removeAll()
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
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
            if peg == Code.missingPeg {
                return
            }
        }
        attempts.append(attempt)
        guess.reset()
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
        
    }

}



