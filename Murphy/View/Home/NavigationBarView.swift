//
//  NavigationBarView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - Properties
    
    @State private var isAnimeted : Bool = false
    
    // MARK: - Body
    var body: some View {
        HStack{
            Spacer()
            
            LogoView()
                .opacity(isAnimeted ? 1 : 0)
                .offset(x: 0 , y: isAnimeted ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5)){
                        isAnimeted.toggle()
                    }
                })
                .onDisappear(perform: {
                    withAnimation(.easeOut(duration: 0.5)){
                        isAnimeted.toggle()
                    }
                })
            
            Spacer()
        }//: Hstack
    }
}

// MARK: - Preview
#Preview {
    NavigationBarView()
}
