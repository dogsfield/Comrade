//
//  DataStorage.swift
//  Comrade
//
//  Created by Michal Miedlarz on 27.02.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation

public protocol DataStorage
{
    func store(chunk: DataChunk)
    func fetch<T: DataChunk>(type: T.Type)
}
