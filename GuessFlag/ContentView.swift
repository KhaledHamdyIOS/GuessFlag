//
//  ContentView.swift
//  GuessFlag
//
//  Created by khaled on 7/5/20.
//  Copyright © 2020 khaledHamdy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var count = 0
  @State var correctAnswer = Int.random(in: 0...2)
  @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
      VStack (spacing: 30){
        VStack {
          Text("Tap the flag of")
          Text(countries[correctAnswer])
            .font(Font.largeTitle)
          
        }
        .foregroundColor(.white)
        
        ForEach(0..<3) {number in
          Button(action: {
            self.showingScore = true
            self.flagTapped(number)
          }) {
            Image(self.countries[number]).renderingMode(.original)
              .clipShape(Capsule())
              .shadow(color: .blue, radius: 10)
          }
        }
        .alert(isPresented: self.$showingScore) {
          Alert(title: Text(self.scoreTitle), message: Text("Your score is \(count)"), dismissButton: .default(Text("Ok")){
            self.askQuestion()
            })
        }
        Spacer()
      }
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      count += 1
    } else {
      scoreTitle = "Wronge"
      count -= 1
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0..<3)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
