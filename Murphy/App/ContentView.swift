//
//  ContentView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    
    
    
    // MARK: - Functions

    
    
    // MARK: - Body
    var body: some View {
        NavigationStack{
            VStack{
            
            NavigationBarView()
                .padding(.horizontal, 15)
                .padding(.bottom)
                .padding(.top,
                         UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(.white)
                .shadow(color: black.opacity(0.05), radius: 5, x: 0, y: 5)
            
            
                VStack(spacing: 0){
                    // MARK: - Info Section
                    InfoItemTabView()
                        .padding(.vertical)
                        .frame(height: UIScreen.main.bounds.width / 1.475)
                    
                    
                    // MARK: - Menu Section
                    NavigationStackManager()
                    
                    // MARK: - Home Seciton
                    TitleView(title: "Home", backgroundColor: grayWhite)
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                    })//: Scroll
                }//: Vstack
            }//: Vstack
                .ignoresSafeArea(.all, edges: .top)
        }//: navstack
        
        
    }

    
}


#Preview {
    ContentView()
}
