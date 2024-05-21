//
//  ContentView.swift
//  WorkoutActivityRings
//
//  Created by Froehlich, Steffen on 15.03.20.
//  Copyright © 2020 Froehlich, Steffen. All rights reserved.
//

import SwiftUI

enum RingDiameter: CGFloat {
    case small = 0.2
    case medium = 0.33
    case big = 0.46
    case calculated = 1.0
}

struct ActivityArrow: View {
    var doubleArrow: Bool = false
    private let startPoint = CGPoint(x: 20, y: 20)
    
    var body: some View {
        return Path { p in
            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 0, y: 20))
            
            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 12, y: 8))
            
            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 12, y: 32))
            
            if doubleArrow {
                p.move(to:  CGPoint(x: startPoint.x + 8, y: startPoint.y))
                p.addLine(to: CGPoint(x: 20, y: 32))
                
                p.move(to:  CGPoint(x: startPoint.x + 8, y: startPoint.y))
                p.addLine(to: CGPoint(x: 20, y: 8))
            }
        }
        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
    }
}

struct ActivityRing: View {
    @Binding var progress: CGFloat
    
    let ringDia: RingDiameter
    let ringColor: Color
    
    // offset for closing circle and arrows
    private var fullCircleDotOffset: CGFloat { return 350 * -ringDia.rawValue / 2 }
    private let ringThickness: CGFloat = 20.0
    
    var body: some View {
        ZStack {
            if self.progress < 0.98 {
                // background ring
                Circle()
                    .scale(self.ringDia.rawValue)
                    .stroke(ringColor.opacity(0.15), lineWidth: self.ringThickness)
                
                // Activity Ring
                Circle()
                    .scale(self.ringDia.rawValue)
                    .trim(from: 0, to: self.progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [ringColor, ringColor.opacity(0.5)]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.ringThickness, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))
                
                // fix overlapping gradient from full cycle
                Circle()
                    .frame(width: self.ringThickness, height: self.ringThickness)
                    .foregroundColor(ringColor)
                    .offset(y: self.fullCircleDotOffset)
                
            } else {
                // Activity Ring
                Circle()
                    .scale(self.ringDia.rawValue)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [ringColor, ringColor.opacity(0.9)]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.ringThickness, lineCap: .round))
                    .rotationEffect(.degrees((360 * Double(self.progress)) - 90))
                
                // TODO let Circle overlap of underlying ring
                Circle()
                    .frame(width: self.ringThickness, height: self.ringThickness)
                    .offset(y: self.fullCircleDotOffset)
                    .foregroundColor(ringColor.opacity(0.5)) // TODO insert linear Gradient
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: self.ringThickness / 4, y: 0)
                    .rotationEffect(.degrees(360 * Double(self.progress)))
            }
            
            // Activity Arrows
            Image(systemName: "bolt.fill")
                .scaleEffect(0.7)
                .offset(y: -81)
                .foregroundColor(.black)
            Image(systemName: "dumbbell.fill")
                .scaleEffect(0.7)
                .offset(y: -58)
                .foregroundColor(.black)
            Image(systemName: "cube.fill")
                .scaleEffect(0.7)
                .offset(y: -35)
                .foregroundColor(.black)
        }
        .frame(width: 350, height: 350)
    }
}

struct ActivityRings: View {
    @Binding var big: CGFloat
    @Binding var medium: CGFloat
    @Binding var small: CGFloat
    
    var body: some View {
        ZStack {
            // RED ring
            ActivityRing(progress: self.$big, ringDia: .big, ringColor: .yellow)
            // GREEN ring
            ActivityRing(progress: self.$medium, ringDia: .medium, ringColor: .blue)
            // BLUE ring
            ActivityRing(progress: self.$small, ringDia: .small, ringColor: .purple)
        }
    }
}

struct CirclesWorkout: View {
    @State private var progressBig: CGFloat = 1.3
    @State private var progressMedium: CGFloat = 0.7
    @State private var progressSmall: CGFloat =  0.3
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                ActivityRings(big: $progressBig,
                              medium: $progressMedium,
                              small: $progressSmall)
                .onTapGesture {
                    withAnimation {
                        self.progressBig = CGFloat.random(in: 0.0...3.5)
                        self.progressMedium = CGFloat.random(in: 0.0...3.5)
                        self.progressSmall = CGFloat.random(in: 0.0...2)
                    }
                }
                
                Spacer()
                
            }
        }
    }
}

struct CirclesWorkout_Previews: PreviewProvider {
    static var previews: some View {
        CirclesWorkout()
    }
}
