//
//  PageModel.swift
//  Pinch
//
//  Created by Gurleen Kaur on 2023-04-29.
//

import Foundation

struct Page : Identifiable{
    let id: Int
    let imageName: String
}

extension Page{
    var thumbnailName: String{
        return "thumb-" + imageName
    }
}
