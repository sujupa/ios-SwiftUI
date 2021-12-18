//
//  TapBar.swift
//  DesignCode
//
//  Created by Sujay Patil on 18/12/21.
//

import SwiftUI

struct TapBar: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Home")
                }
            ContentView().tabItem{
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TapBar().previewDevice("iPhone 8")
            TapBar().previewDevice("iPhone 11 Pro Max")
        }
    }
}
