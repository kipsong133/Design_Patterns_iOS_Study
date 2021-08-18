
## 전략패턴에 대하여
> Strategy pattern(이하 전략패턴) 은 런타임 중에 교채가 가능한 교체가능한 객체들의 집합이다.

이게 무슨 말이냐…

클래스 다이어그램을 먼저 보겠습니다.

![Strategy패턴클래스다이어그램](https://user-images.githubusercontent.com/65879950/129904138-b5327100-a753-40aa-abc0-fd89669f6b6e.jpeg)

각 box에 대해서 알아보겠습니다.

	- Object using a strategy : 전략패턴을 사용하는 객체입니다. 보통은 UIViewController가 될겁니다. 
	- Strategy Protocol : 모든 전략을 정의하고 있는 프로토콜입니다.
	- Strategies(1~3) : 각각의 프로토콜을 구현하고 있는 전략 객체입니다.

전략이라고 하니 뭔가 의미가 와닿지 않으실 것 같아 좀더 설명드리겠습니다.

전략패턴은 캡슐화 + 동적인 변화 를 적용시킨 패턴입니다.
앱을 이용하다보면, 여러가지 상황에 맞는 로직으로 실행시켜야할 수 있습니다.

그 때마다 다른 전략을 구사해야겠죠.

각각의 전략을 “클래스의 행위” 라고 보면 그 단위별로 캡슐화하여 미리 세팅합니다.
그리고 로직에 맞게 전략을 변경하는 것이고,

이를 패턴화 시킨것이 전략패턴입니다.
<br/><br/>


## 언제 전략패턴을 사용하면 좋을까?
위에서 말씀드린 것처럼, 전략패턴은 2 개 이상의 다른 행위가 필요하고 이를 교체할 가능성이 있는 로직에서 사용하면 됩니다.

이 패턴은 이전에 작성한 글인 delegate pattern(델리게이트 패턴) 과 유사합니다.

두 패턴 모두 프로토콜을 통해서 특정 객체를 혹은 로직을 추가하고 있죠.

다른점이 있다면, 전략 패턴은 런타임 도중에 변경된다는 점이죠. 델리게이트 패턴은 고정된 패턴으로만 동작하겠구요.

좀더 구체적인 예시를 들어보겠습니다.

“카카오 맵” 과 같이 이동경로를 알려주는 어플리케이션이 있습니다.

최초에 개발할 때는 자동차 이동경로만 알려줬습니다.
이후에 도보 이동경로를 추가했고
마지막으로 대중교통 이동경로를 추가했습니다.

각각 알고리즘이 다르겠죠. 

자동차이동경로는 도로교통상황 + 내 위치 + 도로 파라미터에 따른 결과값을 산출해야합니다.

도보 이동경로는 도보이용가능여부 + 내위치 에 따라서 결과값을 산출하겠죠.

대중교통이동경로는 대중교통 이용가능여부 + 내위치 에 따라서 결과값을 산출하고요.

파라미터에 따라서 결과값이 다르기도하고, 아마 처리해야하는 로직 또한 다를겁니다.

이 모든 알고리즘은 서로 영향을 주지 않을겁니다. 독립적으로 행동하죠.

이들을 각각 구현해서 캡슐화 합니다. 그리고 사용자가 대중교통을 클릭했다면, 해당 로직에 맞는 전략을 실행시키면 될 것입니다.
<br/><br/>


## CommandLine example
CommandLine으로 콘솔을 통해서 작동하도록 프로젝트를 구성했습니다.
해당 프로젝트는 아래 링크에서 다운로드 받으실 수 있습니다.
[Design_Patterns_iOS_Study/5_Strategy Pattern_exampleProject at main · kipsong133/Design_Patterns_iOS_Study · GitHub](https://github.com/kipsong133/Design_Patterns_iOS_Study/tree/main/5_Strategy%20Pattern_exampleProject)

전략 패턴을 구현할 때, 제일 중요한 점은
1. 전략 프로토콜구현
2. 전략 프로토콜을 준수하는 클래스 구현
3. 전략 프로토콜을 준수하는 클래스 전환 방법

이 세가지 입니다.

제일 중요하다고 한 이유는, 다른 패턴과 차이점이기 때문입니다.

프로젝트의 나머지 부분은 주석처리를 해놓은 부분이고, 이번 단원과 무관한 내용이므로 생략하겠습니다. 필요한 부분만 설명을 적겠습니다.

프로젝트는 교통수단을 고르고 해당 교통수단의 최적거리를 알려주는 로직을 구현합니다.
~~실제로 알고리즘은 없고 print문 만 출력합니다.~~

1. 프로토콜을 선언합니다.
```swift
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
```

이 프로토콜은 전략 객체에 모두 동일하게 구현해야하므로 잘 생각해서 구현해야합니다.

2. 각 전략들을 캡슐화한다.
```swift
// 3 전략을 각각 class로 캡슐화 한다.

class myFoot: RouteStrategy { ... }

class myCar: RouteStrategy { ... }

class seoulBus: RouteStrategy { ... }
```

각 객체가 바로 이전에 작성했던 전략들을 채택하고있습니다.

그러면 프로토콜 준수사항을 지켜서 각각 프로퍼티나 메소드를 구현하고 있겠죠.

여기까지 전략 프로토콜을 작성하고 전략을 구성했습니다.

이후에 이것들을 분기문처리나 if-else 를 활용해서 전략을 switching 해주면 됩니다.

3. 전랴을 스위칭할 방법을 고안한다.
```swift
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

```
<br/><br/>

## 정리
Q. 전략패턴이 무엇인가?
Q. 전략패턴은 언제 사용하는가?
Q. 전략패턴 구현 방법은 어떻게 되는가?

위 질문에 대답하도록 글을 구성했습니다.

읽어주셔서 감사합니다~!

<br/><br/>


### 추가 참고자료
---
- [Swift 디자인 패턴 Strategy Pattern (전략) - 디자인 패턴 공부 22](https://icksw.tistory.com/m/259)
- [Strategy Pattern (with iOS, Swift) :: 고무망치의 Dev N Life](https://rhammer.tistory.com/347)
