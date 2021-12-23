//
//  CourseList.swift
//  DesignCode
//
//  Created by Sujay Patil on 20/12/21.
//

import SwiftUI

struct CourseList: View {

    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show        : self.$courses[index].show,
                                course      : self.$courses[index],
                                active      : self.$active,
                                index       : index,
                                activeIndex : self.$activeIndex
                            )
                                .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
//                            Text("\(geometry.frame(in: .global).maxY),                      \(screen.height)").foregroundColor(.white).bold().padding(.leading, 10)
                        }
    //                    .background(.black)
                        .frame(height: 280)
                        .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
    //            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
        }
//        .animation(.linear)
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show: Bool
    @Binding var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for i0S and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'11 get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight : show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subTitle)
                            .foregroundColor(Color.white.opacity(0.7))
                        Text("\(activeView.height)").foregroundColor(.black).bold().zIndex(1)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        course.logo
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                course.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(course.color)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: course.color.opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                DragGesture().onChanged { value in
                    self.activeView = value.translation
                }
                    .onEnded { value in
                        self.activeView = .zero
                    }
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
//        Text("\(1 - self.activeView.height / 1000)")
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subTitle: String
    var image: Image
    var logo: Image
    var color: Color
    var show: Bool
}

var courseData = [
    Course(title: "Prototype Designs in SwiftUI", subTitle: "18 Section", image: Image("Card1"), logo: Image("Logo1"), color: Color(hue: 0.077, saturation: 1.0, brightness: 0.925), show: false),
    Course(title: "Prototype Designs in SwiftUI", subTitle: "20 Section", image: Image("Card2"), logo: Image("Logo2"), color: Color(hue: 0.941, saturation: 1.0, brightness: 0.906), show: false),
    Course(title: "Prototype Designs in SwiftUI", subTitle: "16 Section", image: Image("Card3"), logo: Image("Logo3"), color: Color(hue: 0.001, saturation: 1.0, brightness: 0.914), show: false)
]
