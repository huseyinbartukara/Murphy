//
//  TitleView.swift
//  Murphy
//
//  Created by Bartu Kara on 4.10.2023.
//

import SwiftUI

struct TitleView: View {
    // MARK: - Properties
    
    var title : String
    var backgroundColor : Color
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .foregroundStyle(red)
                .fontWeight(.heavy)
                .padding(.leading , 20)
                .padding(.top, 4)
                .padding(.bottom, 4)
            
            Spacer()
        }//: HSTACK
        .background(backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

#Preview {
    TitleView(title: "Anasayfa", backgroundColor: grayWhite)
}
