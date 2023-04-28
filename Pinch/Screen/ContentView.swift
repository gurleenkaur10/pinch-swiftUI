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
    @State private var imageOffset: CGSize = .zero
    
    
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
           // MARK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12 , x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .animation(.linear(duration: 1), value: isAnimation)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 6
                            }
                        } else {
                            resetImageState()
                        }
                    })
                    .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)){
                                imageOffset = value.translation
                            }
                        }
                        .onEnded{ _ in
                            if imageScale <= 1{
                               resetImageState()
                            }
                        }
                    )
            }//: zstack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimation = true
            })
            //MARK: - Info Panel
            .overlay(
            InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
            , alignment: .top
            )
            
            //MARK: - Controls
            .overlay(
                Group{
                    HStack{
                        // Scale Down
                        Button{
                            withAnimation(.spring()){
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // Reset
                        Button{
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // Scale Up
                        Button{
                            withAnimation(.spring()){
                                if imageScale < 5{
                                    imageScale += 1
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    }//MARK: - End of control
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimation ? 1 : 0)
                }
                    .padding(.bottom, 30)
                ,alignment: .bottom
            )
        }// NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
