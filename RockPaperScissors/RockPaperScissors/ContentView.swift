//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by kevin dao on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove: Moves = .random()
    @State private var playerShouldWin: Bool = .random()
    @State private var playerScore: Int = 0
    @State private var numRemainingQuestions: Int = 10
    
    enum Moves: CaseIterable, CustomStringConvertible {
        case rock, paper, scissors
        
        static func random() -> Moves {
            .allCases.randomElement()!
        }
        
        var description: String {
            switch self {
            case .rock: return "🪨"
            case .paper: return "📜"
            case .scissors: return "✂️"
            }
        }
    }
    
    struct ChoiceButton: View {
        var choice: Moves
        let action: (Moves) -> Void
        
        init(_ choice: Moves, action: @escaping (Moves) -> Void) {
            self.choice = choice
            self.action = action
        }
        
        var body: some View {
            Button("\(choice.description)") {
                action(choice)
            }
            .padding(16)
            .background(.regularMaterial)
            .clipShape(.circle)
            .font(.system(size: 64))
        }
    }
    
    
    func getCorrectAnswer() -> Moves {
        if playerShouldWin {
            switch appMove {
                case .rock:
                    return .paper
                case .paper:
                    return .scissors
                case .scissors:
                    return .rock
            }
        } else {
            switch appMove {
                case .rock:
                    return .scissors
                case .paper:
                    return .rock
                case .scissors:
                    return .paper
            }
        }
    }
    
    func handleChoiceButton(_ choice: Moves) -> Void {
        let correctAnswer = getCorrectAnswer()
        if choice == correctAnswer {
            playerScore += 1
        }
        numRemainingQuestions -= 1
        playerShouldWin.toggle()
        appMove = .random()
    }
    
    func handlePlayAgainButton() {
        numRemainingQuestions = 10
        playerShouldWin = .random()
        appMove = .random()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if numRemainingQuestions == 0 {
                        Text("Your final score: \(playerScore)")
                            .font(.title)
                            .bold()
                        Button("Play again", action: handlePlayAgainButton)

                    } else {
                        Spacer()
                        Text("app's chooses...")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                        Text("\(appMove.description)")
                            .font(.system(size: 100))
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                        VStack {
                            Text("What would you pick to \(playerShouldWin ? "win" : "lose")?")
                                .font(.title2)
                                .bold()
                            HStack(spacing: 8) {
                                ChoiceButton(.rock, action: handleChoiceButton)
                                ChoiceButton(.paper, action: handleChoiceButton)
                                ChoiceButton(.scissors, action: handleChoiceButton)
                            }
                        }
                        .padding(24)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        
                        Spacer()
                    }
                }

            }
            .frame(maxWidth: .infinity)
            .background(RadialGradient(colors: [.orange, .blue], center: .bottomTrailing, startRadius: 200, endRadius: 201))
        }
    }
}

#Preview {
    ContentView()
}
