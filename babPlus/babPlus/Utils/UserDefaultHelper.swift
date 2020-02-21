//
//  UserDefaultHelper.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/13.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation

enum keyEnums: String {
    case favoriteStr
    case dislike
    case imageKey
}

class UserDefaultHelper {
    private let userDefault = UserDefaults.standard
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private var key: keyEnums
    init(key: keyEnums) {
        self.key = key
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
    
    func subscribeCnt() -> Int {
        return self.getSubscribe()?.count ?? 0
    }
    
    func getSubscribe() -> [SubscribeModels]? {
        guard let data = self.userDefault.object(forKey: self.key.rawValue) as? Data else { return nil }
        return try? decoder.decode([SubscribeModels].self, from: data)
    }
    
    func addData(string: String) {
        var userData = getSubscribe() ?? []
        let subscribeModel = SubscribeModels(name: string)
        userData.append(subscribeModel)
        guard let data = subscribeEncode(subscribeArr: userData) else { return }
        userDefault.set(data, forKey: self.key.rawValue)
    }
    
    func isInData(string: String) -> Bool {
        guard let userData = getSubscribe() else { return false }
        if let _ = userData.firstIndex(where: { (element) in
            element.name == string
        }) {
            return true
        }
        return false
    }
    
    func addData(contentImg: [ContentImage]) {
        guard isEmpty() else { return }
        guard let data = imageEncode(imageArray: contentImg) else { return }
        userDefault.set(data, forKey: self.key.rawValue)
    }
    
    func removeData(str: String) {
        guard var userData = getSubscribe() else { return }
        if let index = userData.firstIndex(where: { (element) in
            element.name == str }) { userData.remove(at: index) }
        
        guard let encodeUserData = subscribeEncode(subscribeArr: userData) else { return }
        userDefault.set(encodeUserData, forKey: self.key.rawValue)
        
    }
    
    private func subscribeEncode(subscribeArr: [SubscribeModels]) -> Data? {
        return try? encoder.encode(subscribeArr)
    }
    
    private func isEmpty() -> Bool {
        return (userDefault.object(forKey: self.key.rawValue) as? Data)?.isEmpty ?? true
    }
    
    private func imageEncode(imageArray: [ContentImage]) -> Data? {
        return try? encoder.encode(imageArray)
        
    }
}
