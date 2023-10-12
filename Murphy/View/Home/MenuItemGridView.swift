//
//  MenuItemGridView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct MenuItemGridView: View {
    
    // MARK: - Properties
    
    @Binding var navPaths : [Routes]
    
    
    var body: some View {
        
       
            ScrollView(.horizontal ,showsIndicators: false, content: {
                LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, content: {
                    ForEach(menus) {menu in
                            Button{
                                if menu.name == "Stopwatch"{
                                    navPaths.append(.stopwatch)
                                }
                                
                                if menu.name == "Pomodoro"{
                                    navPaths.append(.pomodoro)
                                }
                                
                                if menu.name == "Freelancing"{
                                    navPaths.append(.freelancing)
                                }
                                
                                if menu.name == "Message to Self"{
                                    navPaths.append(.message)
                                }
                                
                                if menu.name == "Work Creator"{
                                    navPaths.append(.workcreator)
                                }
                                
                                if menu.name == "Plan Creator"{
                                    navPaths.append(.plancreator)
                                }
                                
                                        } label: {
                                            HStack(alignment: .center, spacing: 6) {
                                                                
                                                                    Image(menu.image)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 30, height: 30, alignment: .center)
                                                                    
                                                                
                                                                Text(menu.name.uppercased())
                                                                    .fontWeight(.light)
                                                                    .foregroundStyle(black)
                                                                
                                                                Spacer()
                                                            }//: Hstack
                                                            .padding()
                                                            .background(grayWhite.cornerRadius(12))
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .stroke(Color.gray, lineWidth: 1.5)
                                                            )
                                    }//:Button
                        }//: Loop
                    
                })//: Grid
                .frame(height: 140)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            })//: Scroll
            .navigationDestination(for: Menu.self){ menu in
                    StopwatchView()
            }
            
        
           
            
        
        
            
       
    }
}

#Preview {
    MenuItemGridView(navPaths: .constant([]))
        .background()
}
