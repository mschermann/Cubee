//
//  ContentView.swift
//  Cubee
//
//  Created by Michael Schermann on 8/30/20.
//  Copyright © 2020 Michael Schermann. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var diceFace: Int = Int.random(in: 1 ... 6)
    
    var body: some View {
        ZStack {
            ShakableViewRepresentable()
            .allowsHitTesting(false)
            DiceFace(face: diceFace, color: .random).onTapGesture {
                self.roll()
            }
        }
        .onReceive(messagePublisher) { _ in
            self.roll()
        }
    }
    
    func roll() {
        var runCount = 0
        let runLimit = Int.random(in: 5 ... 10)
        
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.01 ... 0.6), repeats: true) { timer in
            self.diceFace = Int.random(in: 1 ... 6)
            runCount += 1

            if runCount == runLimit {
                timer.invalidate()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceFace: View {
    
    struct DiceDot: Identifiable, Hashable {
        let id = UUID()
        var xOffset: CGFloat
        var yOffset: CGFloat
    }
    
    let diceFaces = [1: [DiceDot(xOffset: 0, yOffset: 0)],
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
            ForEach(self.diceFaces[face]!) { dot in
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
