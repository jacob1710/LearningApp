//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jacob Scase on 04/07/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    //Current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    //Current Selected content and test
    @Published var currentContentSelected:Int?
    
    @Published var currentTestSelected:Int?
    
    init() {
        getLocalData()
    }
    
    //MARK: Data Methods
    
    func getLocalData(){
        
        
        //Get a url to the json
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        //Read file into data object
        do{
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            //Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //Assign parsed modules to modules properly\
            self.modules = modules
        }catch{
            print(error)
        }
       
        
        // Parse the style data
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        } catch {
            print(error)
        }
        
    }
    //MARK: Module navigation methods
    func beginModule(_ moduleid:Int){
        
        //Find the index for this module id
        for index in 0..<modules.count{
            if modules[index].id == moduleid{
                //Found matching module
                currentModuleIndex = index
                break
            }
        }
        
        //Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int){
        //Check that lsson index is within range of module
        if lessonIndex < currentModule!.content.lessons.count{
            currentLessonIndex = lessonIndex
        }else{
            currentLessonIndex = 0
        }
        
        //Set current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson(){
        //Advance the lesson index
        currentLessonIndex += 1
        
        //Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count{
            
            //Set current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }else{
            //Reset lesson state
            currentLesson = nil
            currentLessonIndex = 0
            
        }
        
       
    }
    
    func hasNextLesson() -> Bool{
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId:Int){
        //Set the current Module
        beginModule(moduleId)
        
        //Set the current question
        currentQuestionIndex = 0
        //If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            //Set the question content
            
            codeText = addStyling(currentQuestion!.content)
        }
        
    }
    
    func nextQuestion(){
        //Advance question
        
        currentQuestionIndex += 1
        
        //Check if in range
        if currentQuestionIndex < currentModule!.test.questions.count{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }else{
            //If not then reset properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
        
    }
    
    //MARK: Code styling
    
    private func addStyling(_ htmlString:String) -> NSAttributedString{
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add styling data
        if styleData != nil{
            data.append(styleData!)
        }
        //Add html data
        data.append(Data(htmlString.utf8))
        
        //Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
                resultString = attributedString
        }
        
        
        return resultString
    }
}
