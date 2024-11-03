//
//  ContentView.swift
//  HeartAnimation
//
//  Created by Hossein Zare on 11/3/24.
//

import SwiftUI

struct EnhancedHeartAnimationView: View {
    @State private var isLiked = false
    @State private var scale: CGFloat = 1.0
    @State private var bounce = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            VStack {
                HeartShape()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [
                            isLiked ? Color.red : Color.gray.opacity(0.5),
                            isLiked ? Color.pink : Color.gray.opacity(0.5)
                        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .scaleEffect(scale)
                    .frame(width: 120, height: 120)
                    .shadow(color: isLiked ? Color.red.opacity(0.5) : Color.gray.opacity(0.4), radius: 15, x: 0, y: 5)
                    
                        // Glowing border effect
                    
                    .offset(y: bounce ? -10 : 0) // Bouncing effect
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: bounce)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isLiked.toggle()
                            scale = isLiked ? 1.2 : 1.0
                            pulse.toggle()
                        }
                        withAnimation(.easeInOut(duration: 0.3).delay(0.2)) {
                            scale = 1.0
                        }
                    }
                    .onAppear {
                        // Start bouncing effect
                        bounce.toggle()
                    }

                Text(isLiked ? "You Liked It!" : "Tap to Like")
                    .font(.headline)
                    .foregroundColor(isLiked ? .red : .black)
                    .padding(.top, 5)
                    .fontWeight(.bold)
                    .scaleEffect(isLiked ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: isLiked)
            }
        }
        .padding()
    }
}

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height / 2 + height / 4))
        path.addCurve(to: CGPoint(x: 0, y: height / 4), control1: CGPoint(x: width / 2, y: height), control2: CGPoint(x: 0, y: height / 2))
        path.addArc(center: CGPoint(x: width / 4, y: height / 4), radius: width / 4, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        path.addArc(center: CGPoint(x: width * 3 / 4, y: height / 4), radius: width / 4, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        path.addCurve(to: CGPoint(x: width / 2, y: height / 2 + height / 4), control1: CGPoint(x: width, y: height / 1.9),control2: CGPoint(x: width / 3.1, y: height))

        return path
    }
}

struct ContentView: View {
    var body: some View {
        EnhancedHeartAnimationView()
    }
}


#Preview {
    ContentView()
}
