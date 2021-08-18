//
//  main.swift
//  StrategyPatternExampleProject
//
//  Created by 김우성 on 2021/08/18.
//

import Foundation

// 1 교통수단을 열거형으로 선언한다.
enum Transportation: String {
    case foot = "내 두발"
    case car  = "그랜저XG"
    case bus  = "272"
}

// 2 공통으로 준수할 프로토콜을 선언한다.
protocol RouteStrategy {
    // 교통수단
    var transportation: Transportation { get }
    
    // 최단거리 결과 메소드
    func calculateShortestDistance(_ by: Transportation,
                                   distance: (String) -> ())
    
    // 최단거리 알고리즘 메소드
    func shortcut(_ start: String, _ end: String) -> String
}

// 3 전략을 각각 class로 캡슐화 한다.

class myFoot: RouteStrategy {
    var transportation: Transportation = .foot
    
    func calculateShortestDistance(_ by: Transportation, distance: (String) -> Void) {
        
        print("탑승수단은 \(transportation.rawValue)")
        distance(shortcut("신촌", "속초"))
    }
    
    func shortcut(_ start: String, _ end: String) -> (String) {
        
        print("startpoint is \(start), endpoint is \(end)...")
        return "TEST"
    }
}

class myCar: RouteStrategy {
    var transportation: Transportation = .car
    
    func calculateShortestDistance(_ by: Transportation, distance: (String) -> Void) {
        
        print("탑승수단은 \(transportation.rawValue)")
        distance(shortcut("신촌", "속초"))
    }
    
    func shortcut(_ start: String, _ end: String) -> (String) {
        
        print("startpoint is \(start), endpoint is \(end)...")
        return "TEST"
    }
}

class seoulBus: RouteStrategy {
    var transportation: Transportation = .bus
    
    func calculateShortestDistance(_ by: Transportation, distance: (String) -> Void) {
        
        print("탑승수단은 \(transportation.rawValue)")
        distance(shortcut("신촌", "속초"))
    }
    
    func shortcut(_ start: String, _ end: String) -> (String) {
        
        print("startpoint is \(start), endpoint is \(end)...")
        return "TEST"
    }
}


// 4 해당 전략을 구사할 객체를 생성한다.
func continueLoop() {
    
    // 무한루프
    while true {
        print("탑승 가능 수단 : 1)foot 2)car 3)bus")
        guard let inputStr = readLine() else { return }
        print("\(inputStr) 을 고르셨습니다.")
        
        // 5 input 값에 따라서 다른 전략을 호출한다.
        switch inputStr {
        case "foot":
            myFoot().calculateShortestDistance(.foot) { _ in
                // do something
            }
        case "car":
            myCar().calculateShortestDistance(.car) { _ in
                // do something
            }
        case "bus":
            seoulBus().calculateShortestDistance(.bus) { _ in
                // do something
            }
        default:
            break
        }
    }
}

continueLoop()
