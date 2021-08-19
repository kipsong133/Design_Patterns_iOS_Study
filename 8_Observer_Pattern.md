“옵저버” = “관찰자”


> 옵저버 패턴은 객체의 상태변화를 관찰자들을 특정 객체에 등록하여 특정 객체의 상태변화가 있을 때마다 관찰자들에게 알려주는 디자인 패턴입니다.

Swift 5.1 부터 Combine 에서 Publisher를 추가하여 이 개념을 Language-level에서 지원하고 있습니다.

클래스 다이어그램을 먼저 보겠습니다.
![](https://images.velog.io/images/kipsong/post/fbb969b9-6aa7-4d0f-8c1b-a0a9a694b5ef/%E1%84%8B%E1%85%A9%E1%86%B8%E1%84%8C%E1%85%A5%E1%84%87%E1%85%A5%E1%84%91%E1%85%A2%E1%84%90%E1%85%A5%E1%86%AB_%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%84%89%E1%85%B3%E1%84%83%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A5%E1%84%80%E1%85%B3%E1%84%85%E1%85%A2%E1%86%B7.jpeg)

1. 구독자 (Subscriber) 는 “옵저버 (Observer)” 이고 업데이트된 사항을 전달받습니다.
2. 발행자 (Publisher) 는 “옵저버블 (Observable)” 이고 업데이트를 전달합니다.
3. 값 (Value) 는 오브젝트에서 변경된 데이터입니다.
(옵저버와 옵저버블을 그냥 해석하지 않은 이유는 해석하는 것이 더 어색해서 그렇게 했습니다.)
<br/><br/>


### 언제 옵저버패턴을 사용할까?

> 옵저버 패턴은 변경사항을 수신하여 특정한 무언가 Task를 처리할 필요가 있을 때, 사용합니다.

좀 추상적이죠?

구체적으로 예시를 들면,

UITableview에서 셀을 생성하기 위해 특정 Array의 데이터의 count 값 만큼 cell을 생성한다고 가정합시다.

그러면 Array 데이터가 변경된다면, UITableview를 다시 그려야할 필요가 있겠죠.

이럴 때, 옵저버블 객체를 Array로 설정하여, 값이 변경될 때마다 

`tableview.reloadData()` 를 실행하면 될겁니다.


옵저버 패턴은 MVC에서 주로 활용됩니다. 

뷰컨트롤러는 구독자이고 모델은 발행자입니다.

이 관계로 인해서 모델과 뷰컨트롤러가 소통이 가능하죠.
<br/><br/>


## Example
아주 간단한 Combine을 활용해보겠습니다.

```swift
// 1 컴바인을 임포트한다.
import Combine

// 2 User 클래스를 정의한다.
public class User {
    
    // 3 멤버변수를 정의한다.
    @Published var name: String
    
    // 4 초기화함수를 정의한다.
    public init(name: String) {
        self.name = name
    }
}
```

3 번부분만 설명드리겠습니다.

직관적이죠. “@Published” 라는 프로퍼티래퍼가 있고 변수명은 “name” 입니다.

name의 값이 변경되면 update를 구독자에게 알릴 예정입니다.

~~당연히 업데이트 되기 위해서는 “let”으로 선언되어선 안되겠죠?~~

다음코드입니다.
```swift
// 1 "User" 인스턴스를 생성한다.
let user = User(name: "Ray")

// 2 발행자에 접근하여 값을 전달받는다.
let publisher = user.$name

// 3 구독자를 생성한다.
var subscriber: AnyCancellable? = publisher.sink() {
    print("User's name is \($0)")
}

// 4 값을 업데이트한다.
user.name = "Vicki"
```


결과
```
User's name is Ray
User's name is Vicki

subscriber = nil
user.name = "Ray has left the building"
```
<br/><br/>


## 옵저버패턴 유의사항
옵저버 패턴을 사용하기 전에 ‘어떤변화를 기대하는지’ 그리고 ‘어떤 조건에서 기대하는지’ 를 먼저 생각하고 사용해야합니다.

만약 그 이유에 대해서 명확하게 정의하지 못한다면, 사용하지 않는 것이 나을 수 있을겁니다.
(값이 변할때마다 로직이 동작할 텐데, 이것들이 쌓이기 시작하면 디버깅을어렵게 하곤합니다.)


## 정리
Q. 옵저버 패턴은 무엇인가?
Q. 옵저버 패턴은 어떻게 구성되어 있는가

에 답할 수 있게 글을 작성했습니다.


읽어주셔서 감사합니다~!

