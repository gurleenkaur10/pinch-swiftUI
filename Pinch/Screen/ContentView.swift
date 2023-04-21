//
//  ContentView.swift
//  Pinch
//
//  Created by Gurleen Kaur on 2023-04-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimation: Bool = false
    @State private var imageScale: CGFloat = 1
    var body: some View {
        NavigationView{
            ZStack{
           // MARK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12 , x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimation)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 6
                            }
                        } else {
                            withAnimation(.spring()){
                                imageScale = 1
                            }
                        }
                    })
            }//: zstack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimation = true
            })
        }// NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}