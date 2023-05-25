//
//  ContentView.swift
//  Heroiney
//
//  Created by Alfine on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    @State var isStart = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: 97/255, green: 255/255, blue: 175/255), Color(red: 197/255, green: 197/255, blue: 197/255)], startPoint: .top, endPoint: .bottom)
            VStack {
                Image("money")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
//            .background(.blue)
            .padding()
            VStack{
                Text("HEROINEY")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                Text("Get to Know Your National Hero in Money")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
//                    .padding(.top, -32)
                
                Button {
                    isStart = true
                } label: {
                    Text("Start")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 50)
                        .background(Color(red: 73/255, green: 178/255, blue: 96/255))
                        .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                        .cornerRadius(8)
                }
                .padding(.top, 75)

            }
        }
        .statusBarHidden()
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isStart) {
            CameraView()
                
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
