//
//  DataManager.swift
//  DataModelOnLocalDevice
//
//  Created by Pooya on 2020-10-11.
//  Copyright © 2020 centurytrail.com. All rights reserved.
//

import Foundation

public class DataManager {
    
    //get Document Directory
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document")
        }
    }
    
    //Save any kind of codeable objects
    static func save<T:Encodable>(_ object:T , with fileName:String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory : false)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
    //loda any kind of data of codeable objest
    static func load<T:Decodable>(_ fileName:String, with type:T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory : false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }catch{
                fatalError(error.localizedDescription)
            }
        }else{
            fatalError("Data unavaiable at path \(url.path)")
        }
    }
    
    //load data fromfile
    static func load(_ fileName:String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory : false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            return data
        }else{
            fatalError("Data unavaiable at path \(url.path)")
        }
    }

    //load all files from a directory
    static func loadAll<T:Decodable>(_ type:T.Type)->[T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            return modelObjects
        } catch {
            fatalError("could not lead any files")
        }
    }
    
    //delete a file
    static func delete(_ fileName:String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
               try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }
    
    
}
