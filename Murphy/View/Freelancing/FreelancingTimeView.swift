//
//  FreelancingTimeView.swift
//  Murphy
//
//  Created by Bartu Kara on 9.10.2023.
//

import SwiftUI
import CoreData

struct FreelancingTimeView: View {
    // MARK: - Properties
    
    @State var subject : String = ""
    @State private var timerLength: Float = 25 * 120
    @State private var currentTime: Float = 25 * 120
    @State private var isRunning = false
    @State private var isStarted = false
    @State private var previousIsRunning = false
    @State private var freelanceTimer = [String]()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var toggle = false
    
    // MARK: - Fetching Data
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FreelanceData.timestamp, ascending: true)],
        animation: .default)
    private var items : FetchedResults<FreelanceData>
    
    // MARK: - Functions
    
    
    
    private func addItem() {
        self.isRunning = true
        self.isStarted = true
        if self.isRunning {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        else {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        
        let newItem = FreelanceData(context: viewContext)
        newItem.name = subject
        newItem.id = UUID()
        newItem.time = currentTime
        newItem.timestamp = Date()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    private func hiddenConditionally(isHidden: Bool) -> some View {
            isHidden ? AnyView(self.hidden()) : AnyView(self)
        }
    
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(grayWhite)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 16) {
                    TextField("Subject:", text: $subject)
                        .padding()
                        .background(grayWhite)
                        .clipShape(.buttonBorder)
                        .font(.title)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.white)
                        
                    
                    HStack(spacing: 20) {

                        HStack{
                            Text("Time:")
                                .frame(minWidth: 16, alignment: .leading)
                                .font(.title)
                                .foregroundStyle(red)
                                .fontWeight(.bold)
                            
                            Text("\(Int(timerLength/60)) min")
                                .frame(minWidth: 16, alignment: .leading)
                                .font(.title3)
                        }//: Hstack
                        Slider(
                            value: $timerLength,
                            in: 60...60 * 120,
                            step: 60,
                            onEditingChanged: { _ in
                                currentTime = timerLength
                            }
                        ).tint(red)
                    }//: Hstack
                    .padding(.horizontal)
                    
                    if isRunning || isStarted{
                        Button(action: {
                            self.isRunning.toggle()
                            if self.isRunning {
                                UIApplication.shared.isIdleTimerDisabled = true
                            }
                            else {
                                UIApplication.shared.isIdleTimerDisabled = false
                            }
                            
                        }, label: {
                            
                            if isRunning{
                                FreelanceButton(label: "Pause", buttonColor: .gray, textColor: .white)
                            }else{
                                FreelanceButton(label: "Continue", buttonColor: .gray, textColor: .white)
                            }
                            
                        })
                        .hiddenConditionally(isHidden: self.toggle)
                    }
                    
                    Button(action: {
                        
                        
                        
                        if isRunning == true && isStarted == true{
                            self.isRunning.toggle()
                            self.isStarted.toggle()
                            self.subject = ""
                            self.timerLength = 25 * 120
                            self.currentTime = 25 * 120
                            if self.isRunning {
                                UIApplication.shared.isIdleTimerDisabled = true
                            }
                            else {
                                UIApplication.shared.isIdleTimerDisabled = false
                            }
                        }else if !isRunning {
                            
                            if isRunning {
                                self.subject = ""
                                self.currentTime = 25 * 120
                            }else{
                                addItem()
                            }
                            
                            
                            
                            
                        }
                        
                    }, label: {
                        
                        if !isRunning && !isStarted{
                            FreelanceButton(label: "Start", buttonColor: .gray, textColor: .white)
                        }else{
                            FreelanceButton(label: "Stop", buttonColor: .gray, textColor: .white)
                        }
                        
                        
                    })
                    .onReceive(timer) { _ in
                        guard self.isRunning else {return}
                        let _ = print("test")
                        if self.currentTime > 0 {
                            self.currentTime -= 1
                        }
                    }
                    
                }//: Vstack
                .padding(.top, 20)
                
                ZStack {
                    
                    VStack {
                        Text(
                            currentTime != timerLength
                                ? "\(Int((currentTime/60).rounded(.up)))" : "\(Int((timerLength/60).rounded(.up)))"
                        )
                        .font(.system(size: 160, weight: .thin))
                    }//Vstack

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

                }//: Zstack
                Spacer()
                
                // MARK: - List yapısı
                
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading){
                            Text(item.name ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("\(item.time)" ?? "")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }//: Vstack
                    }//: Loop
                }//: List
                
                
            }//: Vstack
        } //: Zstack
    }
}

#Preview {
    FreelancingTimeView().environment(\.managedObjectContext,
                                       PersistenceController.preview.container.viewContext)
}
