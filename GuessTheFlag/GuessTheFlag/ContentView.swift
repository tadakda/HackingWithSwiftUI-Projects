//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kevin dao on 11/17/25.
//

import SwiftUI

struct ContentView: View {
    private let NUM_OF_QUESTIONS: Int = 8
    
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var remainingQuestions: Int
    
    init() {
        self.remainingQuestions = NUM_OF_QUESTIONS
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Text("\(remainingQuestions) questions remaining")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                if remainingQuestions == 0 {
                    Button("Play again", action: askQuestion)
                } else {
                    Button("Continue", action: askQuestion)
                }
            } message: {
                Text("Your score is \(score)")
            }
            .padding()
        }
    }
    
    func resetGame() {
        score = 0
        remainingQuestions = 8
    }
    
    func askQuestion() {
        if remainingQuestions == 0 {
            resetGame()
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        remainingQuestions -= 1

        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
        } else {
            scoreTitle = "Wrong! The correct answer was \(countries[correctAnswer])."
        }
        
        if remainingQuestions == 0 {
            scoreTitle += " The game is over. Your final score is \(score)."
        }
        
        showingScore = true
    }
}

struct FlagImage: View {
    var country: String
    
    init(_ country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
