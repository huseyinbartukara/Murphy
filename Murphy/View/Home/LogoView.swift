//
//  LogoView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(spacing: 3){
         Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
            
            Text("Murphy".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundStyle(black)
        }//: Hstack
    }
}

#Preview {
    LogoView()
}
