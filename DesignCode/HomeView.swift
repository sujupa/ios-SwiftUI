//
//  HomeView.swift
//  DesignCode
//
//  Created by Sujay Patil on 17/12/21.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 28))
                    
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button {
                        //add code here to add functionality to button
                        self.showUpdate.toggle()
                        
                    } label: {
                        Image(systemName: "bell")
    //                        .renderingMode(.original)
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 1, y: 1 )
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10 )
                    }
                    .sheet(isPresented: $showUpdate){
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                                                Double(geometry.frame(in: .global).minX - 30) / -20
                                                           ), axis: (x: 0.0, y: 10.0, z: 0.0))
                            }
                            .frame(width: 275, height: 275)
    //                        .background(.black)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.4), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "Build a SwiftUI App", text: "20 Sections", logo: "Logo2", image: Image("Card2"), color: Color("card2")),
    Section(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo3", image: Image("Card3"), color: Color("card3"))
]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 32) {
            //first card
            HStack(spacing: 12.0) {
                RingView(color1: Color(red: 0.00, green: 0.30, blue: 0.81) , color2: Color(red: 0.27, green: 0.67, blue: 0.91), width: 44, height: 44, percent: 68, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .bold()
                        .modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                    
                }
                .modifier(FontModifier())
                
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            // second card
            HStack(spacing: 12.0) {
                RingView(color1: Color(red: 0.86, green: 0.24, blue: 0.00) , color2: Color(red: 1.00, green: 0.62, blue: 0.24), width: 34, height: 34, percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            //third card
            HStack(spacing: 12.0) {
                RingView(color1: Color(red: 0.53, green: 0.00, blue: 1.00) , color2: Color(red: 0.94, green: 0.47, blue: 1.00), width: 34, height: 34, percent: 3, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
