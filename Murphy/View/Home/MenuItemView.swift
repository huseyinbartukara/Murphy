//
//  MenuItemView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct MenuItemView: View {
    // MARK: - Properties
    
    let menu : Menu
    
    
    
    
    
    
    
    // MARK: - Functions
    
    
    
    // MARK: - Body
    var body: some View {
        
        
                Button{
                        
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
    }
}

// MARK: - Preview
#Preview {
    MenuItemView(menu: menus[0])
}
