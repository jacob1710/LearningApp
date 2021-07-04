//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jacob Scase on 04/07/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    
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
    
}
