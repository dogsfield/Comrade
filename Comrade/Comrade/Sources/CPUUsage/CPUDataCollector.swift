//
//  CPUDataCollector.swift
//  Comrade
//
//  Created by Nomtek on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//
import Foundation
public class CPUDataCollector: NSObject, DataCollector
{
    public weak var delegate: DataCollectorDelegate?
    public let timeInterval: Double    
    private var timer: Timer?
    
    init(timeInterval: Double)
    {
        self.timeInterval = timeInterval
    }
    
    //MARK: DataCollector interface implementation
    public func start()
    {
        clearTimer()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(collectCPUData), userInfo: nil, repeats: true)
    }
    
    public func stop()
    {
        clearTimer()
    }
    
    public func isRunning() -> Bool
    {
        return timer != nil
    }
    
    //MARK: Utils
    func collectCPUData()
    {
        let usage = GDCPUUsage.collectCPUUsage()
        delegate?.dataCollector(sender: self, handleChunk: CPUDataChunk(usageLevel: usage), error: nil)
    }
    
    private func clearTimer()
    {
        timer?.invalidate()
        timer = nil
    }
}
