//
//  URLconverter.swift
//  VKClientServer
//
//  Created by пользовтель on 13.07.2021.
//

import UIKit

func converterURLtoImage (url: URL) -> UIImage? {
    guard let data = try? Data(contentsOf: url) else {return nil}
    guard let image = UIImage(data: data) else {return nil}
    return image
    
} 
