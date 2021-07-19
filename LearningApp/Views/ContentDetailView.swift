//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Jacob Scase on 10/07/2021.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack{
            //Only show video if have a valid URL
            if url != nil{
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                    
                    
            }
            
            //TODO: Description
            CodeTextView()
            //Show next lesson button only if there is one
            if model.hasNextLesson(){
                Button(action: {
                    //Advance the lesson
                    model.nextLesson()
                }, label: {
                    
                    ZStack{
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    
                    
                })
            }else{
                //Show complete button instead
                Button(action: {
                    //Take user back to home view
                    model.currentContentSelected = nil
                }, label: {
                    
                    ZStack{
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    
                    
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
