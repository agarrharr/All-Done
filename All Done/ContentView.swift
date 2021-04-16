//
//  ContentView.swift
//  All Done
//
//  Created by Adam Garrett-Harris on 4/16/21.
//

import SwiftUI

struct ContentView: View {
    @State var isRunning: Bool = false
    @State var endTime: Date? = nil
    @State var timeRemaining: Double? = 600.0
    
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
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
                    TimerRow(isRunning: $isRunning, endTime: $endTime, timeRemaining: $timeRemaining)
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
    
    @Binding var isRunning: Bool
    @Binding var endTime: Date?
    @Binding var timeRemaining: Double?
    
    var secondsRemaining: Double {
        if let timeRemaining = timeRemaining {
            return timeRemaining
        }
        let seconds = endTime!.timeIntervalSince(Date())
        return seconds < 0 ? 0.0 : seconds
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(minutes):\(padNumber(n: seconds))")
                    .font(.title)
                    .foregroundColor(secondsRemaining == 0 ? Color.red : Color("textColor"))
                Text("until 5 minute warning")
                    .foregroundColor(Color("textColor"))
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
                    .foregroundColor(Color("textColor"))
                    .frame(width: 40, height: 40)
            }
        }
        .padding()
        .background(Color.accentColor)
        .cornerRadius(10)
        .padding(.horizontal, 10.0)
        .onAppear {
            if let timeRemaining = timeRemaining {
                seconds = Int(timeRemaining) % 60
                minutes = Int(timeRemaining) / 60
            }
        }
    }
    
    func startTimer(){
        isRunning = true
        endTime = Date(timeInterval: timeRemaining!, since: Date())
        timeRemaining = nil

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ tempTimer in
            let totalSeconds = secondsRemaining
            seconds = Int(totalSeconds) % 60
            minutes = Int(totalSeconds) / 60
        }
    }
    
    func stopTimer(){
        isRunning = false
        timeRemaining = secondsRemaining
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
