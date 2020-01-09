//
//  File.swift
//  finalProject
//
//  Created by User11 on 2019/12/18.
//  Copyright © 2019 alice. All rights reserved.
//
import Foundation

struct Files {
    var name: String
    var text: String
}

extension Files {
    init(dic: [String: Any]) {
        name = dic["name"] as? String ?? "???"
        text = dic["text"] as? String ?? "error"
    }
}
