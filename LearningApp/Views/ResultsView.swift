//
//  ResultsView.swift
//  LearningApp
//
//  Created by Jacob Scase on 23/07/2021.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var model:ContentModel
    var numCorrect: Int
    
    var resultHeading:String{
        guard model.currentModule != nil else{
            return ""
        }
        let percent = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if percent > 0.5{
            return "Awesome!"
        }else if percent>0.2{
            return "Doing Great!"
        }else{
            return "Keep Learning"
        }
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions correct")
            
            
            Spacer()
            Button(action: {
                //Send user back to the home view
                model.currentTestSelected = nil
            }, label: {
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
                
            })
            .padding()
        }
    }
}
