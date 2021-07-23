//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Jacob Scase on 10/07/2021.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index:Int
    var lesson:Lesson{
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count{
            return model.currentModule!.content.lessons[index]
        }else{
            return Lesson(id: 0, title: "Loading", video: "", duration: "", explanation: "")
        }
    }
    var body: some View {
//        let lesson =  model.currentModule!.content.lessons[index]
        
        //Lesson Card
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height:66)
            
            HStack(spacing: 30){
                Text(String(index+1))
                    .bold()
                VStack(alignment: .leading){
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                        
                }
            }
            .padding()
        }
        .padding(.bottom, 5)
    }
}

