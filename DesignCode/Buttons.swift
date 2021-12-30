//
//  Buttons.swift
//  DesignCode
//
//  Created by Sujay Patil on 31/12/21.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        
                        Color(hue: 0.631, saturation: 0.157, brightness: 0.983)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8873421768, green: 0.9371824524, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color(hue: 0.631, saturation: 0.157, brightness: 0.983), radius: 20, x: 20, y: 20)
                .shadow(color: Color.white, radius: 20, x: -20, y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.597, saturation: 0.098, brightness: 0.997))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
