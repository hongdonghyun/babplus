//
//  UserDefaultHelper.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/13.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation

class UserDefaultHelper {
    private let userDefault = UserDefaults.standard
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()

    enum keyEnums: String {
        case favoriteStr
        case imageKey
    }
    
    func removeAll() {
        for key in self.userDefault.dictionaryRepresentation().keys {
            self.userDefault.removeObject(forKey: key.description)
        }
    }
    
    func getImage() -> [ContentImage]? {
        guard let data = self.userDefault.object(forKey: keyEnums.imageKey.rawValue) as? Data else { return nil }
        return try? decoder.decode([ContentImage].self, from: data)
    }
    
    
    
    func isEmpty(_ key: keyEnums) -> Bool {
        return (userDefault.object(forKey: key.rawValue) as? Data)?.isEmpty ?? true
    }
    
    func addData(str: String) {
        
    }
    
    func addData(contentImg: [ContentImage]) {
        let key = keyEnums.imageKey
        guard isEmpty(key) else { return }
        guard let data = imageEncode(imageArray: contentImg) else { return }
        userDefault.set(data, forKey: key.rawValue)
        print("success")
    }
    
    func removeData(str: String) {
        
    }
    
    func removeData(contentImg: Data) {
        
    }
    
    private func imageEncode(imageArray: [ContentImage]) -> Data? {
        return try? encoder.encode(imageArray)
        
    }
    
    private func imageDecode(iamgeArray: [ContentImage]) {
        
    }
}
