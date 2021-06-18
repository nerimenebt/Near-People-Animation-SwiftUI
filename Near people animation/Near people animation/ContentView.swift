//
//  ContentView.swift
//  Near people animation
//
//  Created by Nerimene on 14/6/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var startAnimation = false
    @State var pulse1 = false
    @State var pulse2 = false
    @State var foundPeople: [People] = []
    @State var finishAnimation = false
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Button(action: {}, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)
                })
                Text(finishAnimation ? "\(peoples.count) people nearBy" : "NearBy Search")
                    .font(.title2)
                    .fontWeight(.bold)
                    .animation(.none)
                
                Spacer()
                Button(action: verifyAndAddPeople, label: {
                    if finishAnimation {
                       Image(systemName: "arrow.clockwise")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)
                    }else {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }).animation(.none)
                
            }.padding()
            .padding(.top, getSafeArea().top)
            .background(Color.white)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse1 ? 3.3 : 0.0)
                    .opacity(pulse1 ? 0 : 1)
                
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse2 ? 3.3 : 0.0)
                    .opacity(pulse2 ? 0 : 1)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 130, height: 130)
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                
                if finishAnimation {
                    Circle()
                        .stroke(Color.blue, lineWidth: 1.4)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .opacity(finishAnimation ? 1 : 0)
                        )
                }else {
                    Circle()
                        .stroke(Color.blue, lineWidth: 1.4)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .opacity(finishAnimation ? 1 : 0)
                        )
                }
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue, lineWidth: 1.4)
                    
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue, lineWidth: 1.4)
                        .rotationEffect(.init(degrees: -180))
                }.frame(width: 70, height: 70)
                .rotationEffect(.init(degrees: startAnimation ? 360 : 0))
                
                ForEach(foundPeople) {people in
                    Image(people.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(4)
                        .background(Color.white.clipShape(Circle()))
                        .offset(people.offset)
                }
            }.frame(maxHeight: .infinity)
            if finishAnimation {
                VStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 50, height: 4)
                        .padding(.vertical, 10)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 15) {
                            ForEach(peoples) {people in
                                VStack(spacing: 15) {
                                    Image(people.img)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    Text(people.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Button(action: {}, label: {
                                        Text("Choose")
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 40)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    })
                                }.padding(.horizontal)
                            }
                        }.padding()
                        .padding(.bottom, getSafeArea().bottom)
                    })
                }.background(Color.white)
                .cornerRadius(25)
                .transition(.move(edge: .bottom))
            }
        }.ignoresSafeArea()
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .onAppear(perform: {
            animateView()
        })
    }
    
    func verifyAndAddPeople() {
        if foundPeople.count < 6 {
            withAnimation {
                var people = peoples[foundPeople.count]
                people.offset = firstFiveOffsets[foundPeople.count]
                foundPeople.append(people)
            }
        }else {
            withAnimation(Animation.linear(duration: 0.6)) {
                finishAnimation.toggle()
                startAnimation = false
                pulse1 = false
                pulse2 = false
            }
            if !finishAnimation {
                withAnimation {foundPeople.removeAll()}
                animateView()
            }
        }
    }
    
    func animateView() {
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)) {
            startAnimation.toggle()
        }
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)) {
            pulse1.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)) {
                pulse2.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
