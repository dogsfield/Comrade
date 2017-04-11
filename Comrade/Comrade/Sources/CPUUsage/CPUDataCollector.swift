//
//  CPUDataCollector.swift
//  Comrade
//
//  Created by Nomtek on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//
import Foundation
class CPUDataCollector: NSObject, DataCollector
{
    weak var delegate: DataCollectorDelegate?
    
    fileprivate var isModuleRunning = false
    var timer: Timer
    let timeInterval: Double
    
    init(timeInterval: Double)
    {
        self.timeInterval = timeInterval
        self.timer = Timer()
    }
    
    public func start()
    {
        isModuleRunning = true
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)     
    }
    
    public func stop()
    {
        isModuleRunning = false
    }
    
    func update()
    {
        let usage = GDCPUUsage.collectCPUUsage()
        delegate?.dataCollector(sender: self, handleChunk: CPUDataChunk(usageLevel: usage), error: nil)
    }
    
    public func isRunning() -> Bool
    {
        return isModuleRunning
    }
}
