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
    
    var styleData: Data?
    
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
    
    
}
