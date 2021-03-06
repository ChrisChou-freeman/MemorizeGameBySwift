//
//  FileReader.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import Foundation

func loadJsonToStruct<T: Decodable>(_ filename: String) -> T{
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func saveStructsToFile<T: Encodable>(_ dataList: [T], to filePath: String){
    let encoder = JSONEncoder()
    do{
        let encodeData = try encoder.encode(dataList)
        let fileUrl = Bundle.main.url(forResource: filePath, withExtension: nil)!
        try encodeData.write(to: fileUrl)
    }catch{
        fatalError("Couldn't save \(dataList) as json file: \n\(error)")
    }
}

