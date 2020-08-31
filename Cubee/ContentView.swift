//
//  ContentView.swift
//  Cubee
//
//  Created by Michael Schermann on 8/30/20.
//  Copyright © 2020 Michael Schermann. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var diceFaces = [Int.random(in: 1...6)]
    @State var diceColor: Color = .random
    @State var diceNumber: String = ""
    @State var numberOfdice: Int = 1
    
    
    var body: some View {
        ScrollView{
        VStack {
            Stepper(onIncrement: {
                self.diceFaces.append(Int.random(in: 1...6))
                self.numberOfdice = self.diceFaces.count
                self.diceNumber = ""
            }, onDecrement: {
                _ = self.diceFaces.popLast()
                self.diceNumber = ""
                self.numberOfdice = self.diceFaces.count
            }){
                Text("\(self.numberOfdice) Dice")
            }
            Text(diceNumber).font(.largeTitle).padding(15)
            VStack {
                ForEach(diceFaces, id: \.self) {face in
                    Dice(face: face, color: .random)
                    }
                }.onTapGesture {
                self.roll()
                self.diceColor = .random
                
            }
        }
    }
    }
    
    func roll() {
        var runCount = 0
        let runLimit = Int.random(in: 5 ... 10)
        
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.01 ... 0.1), repeats: true) { timer in
            
            self.diceFaces = (0..<self.diceFaces.count).map( {_ in Int.random(in: 1...6)} )

            runCount += 1

            if runCount == runLimit {
                timer.invalidate()
                self.diceNumber = "\(self.diceFaces.reduce(0, +))"
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Dice: View {
    
    let id = UUID()
    
    struct DiceDot: Identifiable, Hashable {
        
        let id = UUID()
        var xOffset: CGFloat
        var yOffset: CGFloat
    
    }
    
    let diceCoords = [1: [DiceDot(xOffset: 0, yOffset: 0)],
                     2: [DiceDot(xOffset: -25, yOffset: -25),
                         DiceDot(xOffset: 25, yOffset: 25)],
                     3: [DiceDot(xOffset: 0, yOffset: 0),
                         DiceDot(xOffset: -25, yOffset: -25),
                         DiceDot(xOffset: 25, yOffset: 25)],
                     4: [DiceDot(xOffset: -25, yOffset: -25),
                         DiceDot(xOffset: 25, yOffset: 25),
                         DiceDot(xOffset: -25, yOffset: 25),
                         DiceDot(xOffset: 25, yOffset: -25)],
                     5: [DiceDot(xOffset: -25, yOffset: -25),
                         DiceDot(xOffset: 25, yOffset: 25),
                         DiceDot(xOffset: 25, yOffset: -25),
                         DiceDot(xOffset: -25, yOffset: 25),
                         DiceDot(xOffset: 0, yOffset: 0)],
                     6: [DiceDot(xOffset: -25, yOffset: -25),
                         DiceDot(xOffset: 25, yOffset: 25),
                         DiceDot(xOffset: 25, yOffset: -25),
                         DiceDot(xOffset: -25, yOffset: 25),
                         DiceDot(xOffset: -25, yOffset: 0),
                         DiceDot(xOffset: 25, yOffset: 0)]]
    
    var face: Int
    var color: Color
    
    let circleSize = CGFloat(20)
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .size(width: 100, height: 100)
                .fill(color)
            ForEach(diceCoords[face]!) { dot in
                Circle()
                    .frame(width:self.circleSize, height: self.circleSize)
                    .offset(x: dot.xOffset, y: dot.yOffset)
            }
            
        }.frame(width: 100, height: 100)
    }
}


extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}
