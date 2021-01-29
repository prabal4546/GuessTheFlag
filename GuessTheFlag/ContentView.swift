//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by PRABALJIT WALIA     on 17/08/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag off amigo")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text(String(currentScore))
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                ForEach(0..<3){number in
                    Button(action:{
                        //flag was tapped
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                            .accessibility(label: Text(self.labels[self.countries[number]] ?? "unknown flag"))
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("your score is \(currentScore)"), dismissButton: .default(Text("continue")){
                self.askQuestion()
                })
        }
    
        
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "correct"
            currentScore += 1
        }else{
            scoreTitle = "Wrong, this is the flag of \(countries[number])"
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
     }
}
