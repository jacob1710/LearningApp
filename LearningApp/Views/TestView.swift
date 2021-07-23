//
//  TestView.swift
//  LearningApp
//
//  Created by Jacob Scase on 23/07/2021.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        if model.currentQuestion != nil{
            VStack{
                //Question Number
                
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                //Question
                CodeTextView()
                
                //Answers
                
                //Button
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }else{
            //Test hasnt loaded yet
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
