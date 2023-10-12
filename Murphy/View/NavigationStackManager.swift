//
//  NavigationStackManager.swift
//  Murphy
//
//  Created by Bartu Kara on 5.10.2023.
//

import SwiftUI


enum Routes {
    case pomodoro
    case stopwatch
    case freelancing
    case message
    case workcreator
    case plancreator
    
    
}

struct NavigationStackManager: View {
    
    // MARK: - Properties
    
    @State private var navPaths = [Routes]()
    
    // MARK: - Body
    var body: some View {
        
            NavigationStack(path: $navPaths){
                MenuItemGridView(navPaths: $navPaths).navigationDestination(for: Routes.self) { r in
                    switch(r){
                    case .stopwatch:
                        StopwatchView()
                    case .pomodoro:
                        PomodoroView()
                    case .freelancing:
                        FreelancingView()
                    case .message:
                        MessageView()
                    case .workcreator:
                        WorkCreatorView()
                    case .plancreator:
                        PlanCreatorView()
                    }
                }
            }//:Navstack
            
    }
}

#Preview {
    NavigationStackManager()
}
