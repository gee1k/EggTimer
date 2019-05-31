//
//  EggTimer.swift
//  EggTimer
//
//  Created by Svend Jin on 2019/5/30.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemainning: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}

class EggTimer {
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 360     // default = 6 minutes
    var elapsedTime: TimeInterval = 0
    
    var delegate: EggTimerProtocol?
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    
    var isPaused:Bool {
        return timer == nil && elapsedTime > 0
    }
    
    @objc
    dynamic func timerAction() {
        // 1
        guard let startTime = startTime else {
            return
        }
        
        // 2
        elapsedTime = -startTime.timeIntervalSinceNow
        
        
        // 3
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        // 4
        if (secondsRemaining <= 0) {
            resetTimer()
            delegate?.timerHasFinished(self)
        } else {
            delegate?.timeRemainingOnTimer(self, timeRemainning: secondsRemaining)
        }
    }
    
    // startTimer
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 360
        elapsedTime = 0
        
        timerAction()
    }
}
