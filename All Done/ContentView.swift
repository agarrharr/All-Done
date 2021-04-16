//
//  ContentView.swift
//  All Done
//
//  Created by Adam Garrett-Harris on 4/16/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack() {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Edit")
                    })
                    Spacer()
                    Image(systemName: "gear")
                        .foregroundColor(Color.accentColor)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(Color("headerColor"))
                ScrollView {
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 600.0)
                    TimerRow(timeRemaining: 900.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                    TimerRow(timeRemaining: 300.0)
                }
                .padding(.top, 5)
                .background(Color("backgroundColor"))
            }
            
            GeometryReader { reader in
                Color("headerColor")
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
    }
}

struct TimerRow: View {
    @State var timer: Timer? = nil
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var isRunning: Bool = false
    @State var endTime: Date?
    @State var timeRemaining: Double
    
    var secondsRemaining: Double {
        if isRunning {
            if let endTime = endTime {
                let seconds = endTime.timeIntervalSince(Date())
                return seconds < 0 ? 0.0 : Double(seconds)
            }
            return timeRemaining
        } else {
            return timeRemaining
        }
    }
    
    func textColor() -> Color {
        return isRunning ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(minutes):\(padNumber(n: seconds))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(secondsRemaining == 0 ? Color.red : textColor())
                Text("until 5 minute warning")
                    .foregroundColor(textColor())
            }
            Spacer()
            Button(action: {
                if isRunning {
                    stopTimer()
                } else {
                    startTimer()
                }
            }) {
                Image(systemName: isRunning ? "pause.fill" : "play.fill")
                    .resizable()
                    .foregroundColor(textColor())
                    .frame(width: 40, height: 40)
            }
        }
        .padding()
        .background(isRunning ? Color.accentColor : Color("headerColor"))
        .cornerRadius(10)
        .padding(.horizontal, 10.0)
        .onAppear {
            seconds = Int(timeRemaining) % 60
            minutes = Int(timeRemaining) / 60
        }
    }
    
    func startTimer(){
        isRunning = true
        endTime = Date(timeInterval: timeRemaining, since: Date())

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ tempTimer in
            timeRemaining = secondsRemaining
            
            seconds = Int(timeRemaining) % 60
            minutes = Int(timeRemaining) / 60
        }
    }
    
    func stopTimer(){
        isRunning = false
        endTime = nil
        timer?.invalidate()
        timer = nil
    }

}

func padNumber(n: Int) -> String {
    n < 10 ? "0\(n)" : "\(n)"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
