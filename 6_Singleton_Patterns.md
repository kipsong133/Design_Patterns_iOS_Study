## 싱글톤 패턴에 대하여
> 싱글톤 패턴이란, 특정 객체를 메모리에 한 번만 할당하여(Static) 생성된 객체를 앱 어디에서든 참조할 수 있도록 하는 디자인패턴을 의미합니다.

싱글톤 패턴은 인스턴스가 1 개만 생성됩니다. 즉, 필요할 때마다 새롭게 인스턴스가 생성되어 메모리를 잡아먹는 것이 아닙니다.

그리고 싱글톤 패턴은 **생성패턴(Creation Pattern)** 입니다. 

왜냐하면, 공유 인스턴스를 생성하는 것에 관한 패턴이기 때문이죠.

클래스 다이어그램으로 보겠습니다.
![싱글톤패턴_클래스다이어그램](https://user-images.githubusercontent.com/65879950/130001590-5c17e943-0cb0-4492-8171-62e3fe19fdec.jpeg)
<br/><br/>


## 싱글톤 패턴을 언제사용할까?
클래스의 인스턴스가 두 개 이상 있으면 문제가 발생하거나 논리적이지 않을 때 싱글톤 패턴을 사용합니다.

추가로 “singleton plus” 라고 칭하는 패턴도 주로 사용됩니다.

이 패턴은 사용자가 지정 인스턴스를 생성할 수 있는 경우 사용합니다.
대표적인 예시로 `FileManager` 가 있습니다.

FileManager는 프로젝트 내부 어디서든 파일에 접근할 수 있죠. 이것은 기본값이 싱글톤 입니다. 또 직접 스스로 생성할 수도 있습니다.
<br/><br/>


## Example

### 일반적인 싱글톤 패턴

Apple framework에서 이미 싱글톤을 사용하고 있는 예제를 먼저 보겠습니다.
```swift
import UIKit

let app = UIApplication.shared
```

앱을 실행함에 있어서 UIApplication의 인스턴스가 2 개가 되면 안됩니다.

UIApplication은 하나가 생성되고 이로 인해 하위 window부터 시작해서 각종 앱 실행에 필요한 객체들이 생성되기 때문이죠.

UIApplication이 인스턴스가 2 개란 말은 앱이 2 개 실행된 것이나 다름 없습니다.
```swift
let secondApp = UIApplication()
```

위와 같이 UIApplication의 인스턴스를 생성하면 컴파일에러가 뜰 것입니다.

싱글톤이기에 새로운 인스턴스 생성 자체를 막고 있습니다.

아마 이런 질문이 생기실 겁니다.

> 어떻게 했길래 인스턴스 생성을 막지?
아래 코드를 보겠습니다.

```swift
public class Constant {
  // 1 인스턴스를 생성하고 정적변수로선언
  static let shared = Constant() 

	// 2 초기화 함수를 접근제한자로 선언
	private init() { }
}
```

이렇게 싱글톤을 정의해서 사용합니다.

주석에 적힌것처럼, 공유할 인스턴스를 정적변수로 할당하여, 앱의 모든 곳에서 접근할 수 있도록 합니다.

그리고 개별적인 인스턴스 생성을 제한하기 위해서 젭근제한자 “private”를 추가로 선언합니다.

사용은 다음과 같이 합니다.

```swift
let constant = Constant.shared
```

### 싱글톤 플러스
아래코드를 보겠습니다.

```swift
let defaultFileManager = FileManager.default
let customFileManager = FilManager()
```

파일매니저는 기본적으로 `default` 라는 키워드로 인스턴스를 공유합니다.
그리고 바로 다음줄 보시면, 직접 인스턴스를 구성하기도 가능하죠.

FileManager와 같이 공유 인스턴스 생성과 커스텀 인스턴스 생성이 가능하도록 싱글톤을 구성해보겠습니다.

```swift
public class singletonPlus {
	// 1
	static let shared = singletonPlus()

	// 2
	public init() { }
}
```

1 번 코드를 보시면, 기존과 동일하게 공유 인스턴스를 생성하고 정적변수로 할당했습니다.

2번 코드를 보시면 차이가 느껴지시나요?
![알 수 없음](https://user-images.githubusercontent.com/65879950/130001604-c1c3a0ef-68ba-44e9-80a2-242eb33814d1.jpg)

기존에 싱글톤은 인스턴스 생성을 막기위해서 `priavate` 접근제한자를 사용했습니다.

그에 비해 싱글톤플러스는 public으로 어디서든 접근 가능하도록 했습니다.
이 부분이 차이점입니다.
<br/><br/>


## 싱글톤 사용 시, 유의사항

싱글톤 패턴이 상당히 직관적이고 구현하기도 쉽습니다.
~~easy to use~~

그러다보면 남용할 우려가 있습니다. 

당장은 싱글톤을 활용하면 직면한 문제를 빠르게 해결할 수 있는 경우가 많습니다.
ex. 컨트롤러 간 데이터 전달 .. 등등

> - 특정 데이터가 앱 전반적으로 활용된는데 매번 선언하는 것이 불편하다.
> - 한번 데이터를 쓰면 앞으로 읽어오기만 하면 된다. (혹은 데이터 변경이 아주 드물다.)

위 같은 상황일 때, 보통 유용합니다.

다만 복잡한 로직으로 싱글톤을 사용하게 된다면,
객체 지향 설계 원칙 중 하나인 (개방 - 폐쇄) 원칙을 어긋나게 됩니다. 

싱글톤 데이터를 task 수행중 변경이 일어난다면, Side-effect 발생 우려가 있습니다.
<br/><br/>


## 정리
Q. 싱글톤 패턴이란 무엇인가?
Q. 싱글톤 패턴은 언제 사용하면 좋은가?
Q. 싱글톤 패턴은 어떻게 구현하는가?

위 질문에 답할 수 있도록 작성했습니다.


읽어주셔서 감사합니다.





## 참고자료
- https://gmlwjd9405.github.io/2018/07/06/singleton-pattern.html
- https://jeong-pro.tistory.com/86 
- [Java에서 싱글톤(Singleton) 패턴을 사용하는 이유와 주의할 점 | MHLab Blog](https://elfinlas.github.io/2019/09/23/java-singleton/)
