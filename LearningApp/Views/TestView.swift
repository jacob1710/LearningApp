//
//  TestView.swift
//  LearningApp
//
//  Created by Jacob Scase on 23/07/2021.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var haveSubmitted = false
    @State var showResults = false
    
    var body: some View {
        if model.currentQuestion != nil && !showResults {
            VStack(alignment: .leading){
                //Question Number
                
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                //Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                //Answers
                ScrollView{
                    VStack{
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                            Button(action: {
                                //Track selected index
                                selectedAnswerIndex = index
                            }, label: {
                                ZStack{
                                    if haveSubmitted == false{
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray: .white)
                                            .frame(height:48)
                                    }else{
                                        //Answer has been submitted
                                        if selectedAnswerIndex == index {
                                            if index == model.currentQuestion!.correctIndex{
                                                //If correct selected answer
                                                RectangleCard(color: .green)
                                                    .frame(height:48)
                                            }else{
                                                //If incorrect selected answer
                                                RectangleCard(color: .red)
                                                        .frame(height:48)
                                            }
                                            
                                        }else if index == model.currentQuestion!.correctIndex{
                                            //If not selected correct answer
                                            RectangleCard(color: .green)
                                                .frame(height:48)
                                        }else{
                                            //If not selected incorrect answer
                                            RectangleCard(color: .white)
                                                .frame(height:48)
                                        }
                                        
                                    }
                                   
                                    Text((model.currentQuestion!.answers[index]))
                                    
                                }
                                
                            })
                            .disabled(haveSubmitted)
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                //Submit button
                Button(action: {
                    //Check answer and increment counter if correct
                    if haveSubmitted == true{
                        if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                            //If last question
                            showResults = true
                            
                        }
                        selectedAnswerIndex = nil
                        haveSubmitted = false
                        model.nextQuestion()
                        
                        

                    }else{
                        //Submit
                        haveSubmitted = true
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect+=1
                        }
                    }
                   
                }, label: {
                   
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height:48)
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                })
                .disabled(selectedAnswerIndex == nil)
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        }else if showResults{
            //Test hasnt loaded yet
//            ProgressView()
            ResultsView(numCorrect: numCorrect)
        }else{
            ProgressView()
        }
    }
    var buttonText: String{
        if haveSubmitted == true{
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                return "Complete Quiz"
                
            }else{
               
                return "Next Question"
            }
        }else{
            return "Submit"
        }
    }
}

