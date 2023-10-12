//
//  StopWatchView.swift
//  Murphy
//
//  Created by Bartu Kara on 7.10.2023.
//

import SwiftUI
import UIKit

struct TimerWatchView: View {
    // MARK: - Properties
    
    
    @State private var currentTime : Float = 0 * 25
    @State private var secondTime : Float = 0.0
    @State private var minute : Int = 0
    @State private var isRuning = false
    @State private var isStarted = false
    @State private var previousIsRuning = false
    @State private var pomodoros = [String]()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack{
            Color(grayWhite)
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    
                    HStack{
                        Text("\(minute)")
                        .font(.system(size: 160,weight: .thin))
                        
                        Text(".")
                            .font(.system(size: 50))
                            .offset(x:-12 ,y: 30)
                        
                        Text(
                            "\(Int(currentTime.rounded(.up)))"
                        )
                        
                        .font(.system(size: 45))
                        .offset(x:-12 ,y: 35)
                        
                        
                    }//: Hstack
                    
                    Circle()
                        .rotation(.degrees(-90))
                        .stroke(
                            red.opacity(1),
                            style: StrokeStyle(lineWidth: 12, dash: [CGFloat.pi / 2, CGFloat.pi * 3.5])
                        )
                        .frame(width: 260, height: 260)
                    
                    Circle()
                        .trim(
                            from: 0,
                            to: CGFloat(((currentTime).truncatingRemainder(dividingBy: 60) - 0.25) / 60)
                        )
                        .rotation(.degrees(-90))
                        .stroke(
                            Color.white.opacity(1),
                            style: StrokeStyle(lineWidth: 12, dash: [CGFloat.pi / 2,
                                                                     CGFloat.pi * 3.5])
                        )
                        .frame(width: 260, height: 260)
                }//:Zstack
                
                
                HStack {
                    if pomodoros.count > 0 {
                        Text(pomodoros.joined(separator: " "))
                    }
                }//: Hstack
                .padding(.top, 1).font(.system(size: 36))
                
                ZStack{
                    Button(action: {
                        self.isRuning.toggle()
                        self.isStarted.toggle()
                        if self.isRuning {
                            UIApplication.shared.isIdleTimerDisabled = true
                        }
                        else {
                            UIApplication.shared.isIdleTimerDisabled = false
                        }
                    }) {
                        
                        
                        if (self.isRuning == false && self.isStarted == false){
                            TimerButton(label: "Start", buttonColor: .white, textColor: red)
                        }
                        
                    }//: Button
                    .padding(.trailing)
                    .padding(.bottom, 30)
                    
                    if self.isStarted {
                        Button(action: {
                            self.isRuning.toggle()
                            if self.isRuning {
                                UIApplication.shared.isIdleTimerDisabled = true
                            }
                            else {
                                UIApplication.shared.isIdleTimerDisabled = false
                            }
                        }) {
                            
                            if isRuning == true {
                                TimerButton(label: "Pause", buttonColor: .white, textColor: red)
                            }
                            if isRuning == false {
                                TimerButton(label: "Continue", buttonColor: .white, textColor: red)
                            }
                            
                        } //:Button
                        .padding(.bottom,30)
                        .padding(.trailing)
                    }
                }//: Hstack
            }//:Vstack
            .onReceive(timer) { _ in
                guard self.isRuning else {return}
                let _ = print("Test")
                self.currentTime += 1
                    if currentTime > 59 {
                        currentTime = 0
                        minute  = minute + 1
                    }
                    print(self.currentTime)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .frame(maxWidth: 500, maxHeight: .infinity)
            .foregroundColor(.white)
        }//:Zstack
    }
}

#Preview {
    TimerWatchView()
}
