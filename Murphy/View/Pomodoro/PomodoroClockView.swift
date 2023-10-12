//
//  PomodoroClockView.swift
//  Murphy
//
//  Created by Bartu Kara on 5.10.2023.
//

import SwiftUI
import AVFoundation
import UIKit
import UserNotifications

struct PomodoroClockView: View {
    // MARK: - Properties
    
    @State private var timerLength: Float = 25 * 60
    @State private var breakLength: Float = 5 * 60
    @State private var currentTime: Float = 25 * 60
    @State private var isRunning = false
    @State private var isStarted = false
    @State private var previousIsRunning = false
    @State private var isBreak: Bool = false
    @State private var soundID: Int = 1013
    @State private var isHapticsEnabled: Bool = true
    @State private var isSoundEnabled: Bool = true
    @State private var pomodoros = [String]()
    
    
    enum HapticStyle {
        case light
        case medium
    }
    
    // MARK: - Functions

    func playSound() {
        if isSoundEnabled {
            AudioServicesPlaySystemSound(SystemSoundID(soundID))
        }
    }

    func runHapticFeedback(withStyle style: HapticStyle) {
        if isHapticsEnabled {
            let generator: UIImpactFeedbackGenerator
            switch style {
            case .light:
                generator = UIImpactFeedbackGenerator(style: .light)
            case .medium:
                generator = UIImpactFeedbackGenerator(style: .medium)
            }

            generator.impactOccurred()
        }
    }

    func runHapticSuccessFeedback() {
        if isHapticsEnabled {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification authorization granted.")
            }
            else {
                print("Notification authorization denied.")
            }
        }
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    let gradient = AngularGradient(
        gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
        center: .center
    )
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(grayWhite)
                .edgesIgnoringSafeArea(.all)
            VStack {

                Spacer()

                ZStack {
                    VStack {
                        Text(
                            currentTime != timerLength
                                ? "\(Int((currentTime/60).rounded(.up)))" : "\(Int((timerLength/60).rounded(.up)))"
                        )
                        .font(.system(size: 160, weight: .thin))
                    }

                    Circle()
                        .rotation(.degrees(-90))
                        .stroke(
                            red.opacity(1),
                            style: StrokeStyle(lineWidth: 12, dash: [CGFloat.pi / 2, CGFloat.pi * 3.5])
                        )

                        .frame(width: 240, height: 240)

                    Circle()
                        .trim(
                            from: 0,
                            to: CGFloat(((currentTime).truncatingRemainder(dividingBy: 60) - 0.25) / 60)
                        )
                        .rotation(.degrees(-90))
                        .stroke(
                            Color.white.opacity(1),
                            style: StrokeStyle(lineWidth: 12, dash: [CGFloat.pi / 2, CGFloat.pi * 3.5])
                        )
                        .frame(width: 240, height: 240)

                }

                HStack {
                    if pomodoros.count > 0 {
                        Text(pomodoros.joined(separator: " "))
                    }

                    if self.isRunning {
                        if !self.isBreak {
                            Text("Work Time!").opacity(1)
                        }
                        else {
                            Text("Break Time").opacity(1)
                        }
                    }

                }.padding(.top, 1).font(.system(size: 36))

                Spacer()

                HStack {

                    Text("Work: \(Int(timerLength/60)) min")
                        .frame(minWidth: 120, alignment: .leading)

                    Slider(
                        value: $timerLength,
                        in: 60...60 * 60,
                        step: 60,
                        onEditingChanged: { _ in
                            currentTime = timerLength

                            runHapticSuccessFeedback()
                        }
                    ).tint(red).disabled(isRunning)
                }
                HStack {
                    Text("Break: \(Int(breakLength/60)) min").frame(minWidth: 120, alignment: .leading)
                    Slider(
                        value: $breakLength,
                        in: 60...60 * 20,
                        step: 60,
                        onEditingChanged: { _ in
                            runHapticSuccessFeedback()
                        }
                    ).tint(red).disabled(isRunning)
                }

                Toggle(isOn: $isHapticsEnabled) {
                    Text("Haptics")
                }.tint(Color.red)

                Toggle(isOn: $isSoundEnabled) {
                    Text("Sounds")
                }.tint(Color.red)

                Spacer()

                HStack {
                    Button(action: {
                        self.isRunning.toggle()
                        self.isStarted.toggle()
                        if self.isRunning {
                            UIApplication.shared.isIdleTimerDisabled = true
                        }
                        else {
                            UIApplication.shared.isIdleTimerDisabled = false
                        }
                    }) {
                        Text(self.isRunning || self.isStarted ? "Stop" : "Start").font(.system(size: 24))
                    }.padding(.trailing).padding(.bottom, 30)

                    if self.isStarted {
                        Button(action: {
                            self.isRunning.toggle()
                            if self.isRunning {
                                UIApplication.shared.isIdleTimerDisabled = true
                            }
                            else {
                                UIApplication.shared.isIdleTimerDisabled = false
                            }
                        }) {
                            Text(isRunning ? "Pause" : "Continue").font(.system(size: 24))
                        }.padding(.bottom, 30)
                    }

                }

            }.onReceive(timer) { _ in
                guard self.isRunning else {return}
                let _ = print("test")
                if self.currentTime > 0 {
                    self.currentTime -= 1
                }
                else {
                    if self.isBreak {
                        playSound()
                        self.isBreak = false
                        self.currentTime = self.timerLength
                    }
                    else {
                        playSound()
                        self.isBreak = true
                        self.currentTime = self.breakLength
                    }

                }
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .frame(maxWidth: 500, maxHeight: .infinity)
            .foregroundColor(.white)
        }
        
    }
}

#Preview {
    PomodoroClockView()
}
