//
//  ContentView.swift
//  swiftu ui basic
//
//  Created by Abbos Bobomurodov on 25/05/23.
//

import SwiftUI


struct ContentView: View {

    @State private var yourScore : Int = 0
    @State private var yourScoreTitle : String = ""
    
    @State private var showScore : Bool = false
    
    
   @State private var countries = [ "Estonia", "UK", "US", "Germany", "Spain", "Italy", "Poland","Russia", "Ireland","France","Monaco", "Nigeria"].shuffled()
    
    @State private  var currentAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()
            Spacer()
            
            VStack{
                Text("Gues the Flag")
                    .frame( maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(.title)
                    .foregroundColor(.white)
                    
                Spacer()
                
                
                VStack(spacing: 15){
                    
                    VStack{
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[currentAnswer])
                            .font(.largeTitle.weight(.semibold))
//                            .foregroundColor(.white)
                        
                  
                    }
                    ForEach(0..<3){ number in
                        Button{
                            buttonTaped(tappedFlagId: number, correctFlagId: currentAnswer)
                            showScore = true
                            
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .buttonBorderShape(.capsule)
                                .shadow(radius: 5)
                            
                        }.alert(isPresented: $showScore) {
                            Alert(
                                title: Text("Your answer is: \(yourScoreTitle)"),
                                message: Text("Your Scrore is: \(yourScore)"),
                                dismissButton: .default(Text("Next"),action: {
                                    nextQuestion()
                                })
                                
                            )
                        }
                    }
                    
                    Button{
                        nextQuestion()
                    } label: {
                        Text("Shuffle")
                            .foregroundColor(.red)
                    }.buttonStyle(.bordered)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Spacer()
                Spacer()
                
                Text("Your score: \(yourScore)")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
    
    func buttonTaped(tappedFlagId : Int, correctFlagId: Int){
        
        if tappedFlagId == correctFlagId {
            yourScore += 1
            
            print(yourScore)
        yourScoreTitle = "Correct"
        }else{
            yourScoreTitle = "Wrong"
        }
        
    }
    
    func nextQuestion(){
        countries.shuffle()
        
        currentAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       
            ContentView()
        
    }
}
