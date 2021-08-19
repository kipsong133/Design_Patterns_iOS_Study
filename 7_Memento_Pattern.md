## 메멘토 패턴에 대하여
메멘토?

단어 자체가 익숙하지 않습니다.
> **메멘토**(Memento)는 기억의 증표를 말한다 - 위키백과 -

비슷한 단어로 “메멘토 모리” 라는 단어가 있습니다.

그 단어의 뜻은 “너는 반드시 죽는다는 것을 기억해라.” 라는 뜻이라고 합니다.

메멘토는 무언가 “기억” 하는 행위와 관련된 의미를 가지고 있네요.

메멘토 패턴은 **행동패턴 (Behavioral Patterns)** 에 속합니다. 
왜냐하면 “데이터를 저장하고 복원하는 행동” 에 초첨을 맞췄기 때문이죠.

먼저 클래스 다이어그램을 보겠습니다.
![](https://images.velog.io/images/kipsong/post/c8a5b2c5-ba87-4a22-ac79-79202b38f7b9/%E1%84%86%E1%85%A6%E1%84%86%E1%85%A6%E1%86%AB%E1%84%90%E1%85%A9%E1%84%91%E1%85%A2%E1%84%90%E1%85%A5%E1%86%AB_%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%84%89%E1%85%B3%E1%84%83%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A5%E1%84%80%E1%85%B3%E1%84%85%E1%85%A2%E1%86%B7.jpeg)

메멘토 패턴은 3 개의 객체로 구성됩니다.
- 오리지네이터 (Originator) : 현재 상태정보(State)를 가지고 있습니다. 이 클래스만 Memento 클래스에 접근할 수 있습니다. (클래스 다이어그램 참조) 따라서 Memento 클래스의 생성 & 접근 은 이 클래스를 이용해야합니다.
- 케어테이커 (CareTaker) : Memento를 관리하는 클래스 내부에 Stack 자료형으로 구성되어 있습니다.
- 메멘토 (Memento) : 특정 시점의 Infomation의 “상태정보”를 저장하는 클래스입니다.
<br/><br/>

## 언제 메멘토를 사용하면 좋을까?

> Use the memento pattern whenever you want to save and later restore an object’s state.
(메멘토 패턴은 특정 상태를 저장하고 싶을 때, 언제든 사용하면 됩니다.)

좀 더 와닿는 예시를 들면, “문서작업” 이나 “드로잉작업(컴퓨터로)” 이 있습니다.

문서작업이나 그림을 그리다보면, 가장많이 사용하는 기능인  “실행 취소 (컨트롤 + Z)” 아시죠.

이 Task가 동작하려면 이전 상태에 대한 정보를 가지고 있어야 가능하겠죠.

이런 상황에서 “메멘토 패턴” 을 사용합니다.

> 메멘토 패턴은 객체의 상태정보를 저장하고, 저장한 정보를 통해서 복원할 수 있도록 하는 패턴입니다.

비슷한 다른 예시로 게임이 있습니다.

오리지네티어는 게임 상태를 저장할 겁니다.
ex. 현재 레벨, HP, 죽은 횟수 등등

메멘토는 저장된 데이터 정보를 가지고 있겠죠. 

케어테이커는 게임 시스템이되겠습니다.
<br/><br/>

## Example
코드를 보겠습니다.
```swift
import Foundation

// MARK: - Originator
public class Game: Codable {

  public class State: Codable {
    public var attemptsRemaining: Int = 3
    public var level: Int = 1
    public var score: Int = 0
  }
  public var state = State()

  public func rackUpMassivePoints() {
    state.score += 9002
  }

  public func monstersEatPlayer() {
    state.attemptsRemaining -= 1
  }
}
```


“Game” 클래스가 있습니다. 그리고 그 내부에 다시 “State” 클래스가 있죠. State 클래스의 멤버변수로 “attemptsRemaining”, “level” 그리고 “score” 가 있습니다.

다시 Game 클래스에 멤버변수와 메소드로 “state”, “rackUpMassivePoints” 그리고 “monstersEatPlayer” 가 있습니다.

메소드를 보면 멤버변수인 “state”에 연산한 이후 값을 할당해주고 있네요.

그런데 각 클래스에보면 `Codable` 이라는 친구를 채택하고 있습니다.

Codable은 Swift4 에 도입된 개념입니다. 

Codable을 준수한다면, 어떤 타입이든지 
~~(애플의 말을 옮기면)~~

> “convert itself into and out of an external representation.”

해석해보면, “자기자신을 변환하거나 외부 표현으로 변환한다.” 정도로 해석되네요.

이게 무슨말이냐..

Codable을 채택한 객체는 “변환”이 가능하다는 겁니다. 그런게 그것들이 JSON 과 같은 외부표현으로도 가능하다는 겁니다.

Codable에는 두 가지 프로토콜이 또 있습니다.
- Encodable
- Decodable
여기까지만 설명하고 zeddios 님의 설명으로 대체하겠습니다.
[Swift ) 왕초보를 위한 Codable / JSON Encoding and Decoding](https://zeddios.tistory.com/373)

본론으로 돌아와서 Memento를 선언하겠습니다.

```swift
typealias GameMemento = Data
```

위 코드는 사용자 타입정의입니다. 그러므로 꼭 필요한 코드는 아닙니다.

다만, “GameMemento” 가 Data 타입이라는 것에 주목하시면 됩니다.

Encoder를 통해서 데이터를 저장할 것이고 Decoder를 통해서 데이터를 복원할 예정입니다. (Codable에 대해 잠깐 설명한 이유입니다.)

하나 남았죠?
CareTaker를 작성하겠습니다.
```swift
public class GameSystem {

	// 1 코드화 인스턴스 생성 및 저장소 생성
	private let decoder = JSONDecoder()
	private let encoder = JSONEncoder()
	private let userDefaults = UserDefaults.standard

	// 2 게임데이터를 저장하는 메소드
	public func save(_ game: Game, title: String) throws {
		let data = try encoder.encode(game)
		userDefault.set(data, forKey: title)
	}

	// 3 게임데이터를 불러오는 메소드
	public func load(title: String) throws -> Game {
		guard let data = userDefaults.data(forKey: title),
		 let game = try? decoder.decode(Game.self, from: data)
		 else { throw Error.gameNotFound }
		return game
	}

	// 에러 정의
	public enum Error: String, Error {
		case gameNotFound
	}
}
```

이제 실행해보겠습니다.

```swift
// MARK: - Example
var game = Game()
game.monstersEatPlayer()
game.rackUpMassivePoints()
```

게임을 하다가 저장을 해야한다면, 다음과 같이 호출할겁니다.
```swift
// Save Game
let gameSystem = GameSystem()
try gameSystem.save(game, title: "Best Game Ever")
```

새로운 게임이 하고싶으면 새로운 인스턴스를 생성할겁니다.
```swift
// New Game
game = Game()
print("New Game Score: \(game.state.score)")
// New Game Score: 0
```

이전 게임 목록을 load 하고 싶다면,
```swift
// Load Game
game = try! gameSystem.load(title: "Best Game Ever")
print("Loaded Game Score: \(game.state.score)")
// Loaded Game Score: 9002
```
<br/><br/>


### 이외 참고하면 좋을 예제

[메멘토 패턴 예제 · GitHub](https://gist.github.com/kipsong133/41a39362320963bdab8a4bb3c33a980c) 
해당 예제는 아래 블로그를 참고해서 작성했습니다. 
[Swift 디자인 패턴 Memento Pattern (메멘토) - 디자인 패턴 공부 19](https://icksw.tistory.com/255)
<br/><br/>


## 메멘토패턴 유의사항
- Codable 관련 프로퍼티를 잘 다뤄야합니다. (throw ~ error 처리)
- 데이터를 저장하기에, 너무 많은 저장메모리를 확보해야하는건 아닌지 유의해야합니다.


## 정리
Q. 메멘토 패턴은 무엇인가?
Q. 메멘토 패턴은 언제 사용하는가?
Q. 메멘토 패턴의 구성요소는 각각 어떤 역할을 하는가?
에 대한 대답을 할 수 있도록 글을 작성했습니다.


읽어주셔서 감사합니다.!


## 참고자료
---
- [메멘토 패턴 - 위키백과, 우리 모두의 백과사전](https://ko.wikipedia.org/wiki/%EB%A9%94%EB%A9%98%ED%86%A0_%ED%8C%A8%ED%84%B4)
- [디자인패턴메멘토 패턴 (Memento Pattern)](https://velog.io/@secdoc/%EB%94%94%EC%9E%90%EC%9D%B8%ED%8C%A8%ED%84%B4%EB%A9%94%EB%A9%98%ED%86%A0-%ED%8C%A8%ED%84%B4-Memento-Pattern)
- [Swift 디자인 패턴 Memento Pattern (메멘토) - 디자인 패턴 공부 19](https://icksw.tistory.com/255)


