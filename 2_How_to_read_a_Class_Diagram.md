# 2. How to read a Class Diagram
<br/><br/>
![halacious-weRQAu9TA-A-unsplash](https://user-images.githubusercontent.com/65879950/129724690-3b9f5abd-aa8d-40dd-a25b-7d7da5c16258.jpg)

(이미지출처: https://unsplash.com/photos/weRQAu9TA-A?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink_)

디자인 패턴을 이해하기 위해서 좋은 도구인 “클래스 다이어그램 (Class diagram)” 에 대해서 간략히 알아보겠습니다.

클래스 다이어그램은 “엔지니어링 기획도(혹은 청사진)” 라고 보시면 됩니다.

그 청사진을 화살표와 도형 그리고 특정한 표시를 통해서 나타낼 뿐이죠.
~~고등학교 시절 문학을 읽을 때, 인물관계도 표시하잖아요. 그런 느낌?~~

아마 정보처리기사를 공부해보신 분들은 **UML** 에 대해서 들어보셨을 수도 있을 겁니다. (혹은 전공책)

그 친구를 알아보려고 합니다.

## 클래스 다이어그램에 어떤 것들이 있는데?

클래스 다이어그램에는 다음 항목들을 포함하고 있습니다.
- 프로토콜
- 프로퍼티
- 메소드
- 관계

<br/><br/>
### 클래스
먼저 아래 상자를 보겠습니다.
이 상자는 “Dog” 클래스 를 나타냅니다.

![Dog클래스그림](https://user-images.githubusercontent.com/65879950/129723359-80b58b5a-6745-4bd9-bd7f-088efd07b445.jpeg)



<br/><br/>
### 상속
화살표는 상속(Inheritnace)를 나타냅니다.
그래서 “슈나우저”는 “Dog”를 상속받는다를 표현하면 다음과 같습니다.
![슈나우저상속됨](https://user-images.githubusercontent.com/65879950/129723454-9b531f74-56ec-478a-87b9-43b862229c96.jpeg)


=> 슈나우저는 Dog 이다. 라고 독해할 수 있겠죠.
<br/><br/>
### 프로퍼티
아래 사진의 일반 화살표는 프로퍼티(Property) 을 의미합니다.
UML 의 용어로 연관(association) 을 뜻합니다.

![프로퍼티화살표](https://user-images.githubusercontent.com/65879950/129724096-550f3549-84fc-4d31-b37b-c71b9ae9c603.jpeg)


클래스 다이어그램은 `아래 -> 위` 로 작성합니다.
그리고 `좌 -> 우` 로 작성하고요.

물론 원하는 방식으로 하셔도 됩니다.

상속 화살표는 항상  “부모클래스(supclass)” 를 향합니다.
프로퍼티화살표는 항상 “프로프티클래스”를 향합니다.

예를 들면 다음과 같습니다.

“우노는 Dog를 가지고 있다.” 를 표현한 다이어그램입니다.
![우노HasaDog](https://user-images.githubusercontent.com/65879950/129724113-9ad289c0-ec28-4d44-8f4b-cb3fadc7a343.jpeg)

만약 Dog를 하나 이상 가지고 있다면, 아래와 같이 표현합니다.
![우노Hasoneormore](https://user-images.githubusercontent.com/65879950/129724122-45204e6b-18b1-4683-9c46-00ac2ac8d66c.jpeg)

아무리 복수형이라고해도 “s” 나 “es”는 붙이지 않습니다.

지금까지 본 도형들을 연결하면 다음과 같습니다.
“우노는 슈나우저를 가지고 있는데, 그 슈나우저는 Dog 이다.”
(= 우노 클래스는 슈나우저 프로퍼티를 가지고 있고, 슈나우저 프로퍼티는 Dog를 상속받는다.)

![우노는슈나우저를가지고슈나우저는Dog다](https://user-images.githubusercontent.com/65879950/129724140-e57b6a59-8f17-4cf2-abd0-505cb21625e3.jpeg)

<br/><br/>
### 프로토콜
프로토콜은 다음과 같이 표시합니다
<<protocol>>
반려동물소유
![반려동물소유프로토콜](https://user-images.githubusercontent.com/65879950/129724148-bed84536-29ad-4a2b-ac3f-2b3d0cf17080.jpeg)

그리고 화살표를 이용해서 클래스는 프로토콜을 구현함을 나타냅니다.
그래서 예시로
“우노는 반려동물소유 프로토콜을 구현한다.”
를 나타내보면 다음과 같습니다.
![우노는반려동물소유프로토콜을구현](https://user-images.githubusercontent.com/65879950/129724165-bcb1f7e2-00af-475c-84c9-8a13c6376138.jpeg)

### uses 혹은 의존성
사용 혹은 의존성을 나타내는 화살도 있습니다.

보통 이 화살표는 다음과 같은 상황에서 사용됩니다.
```swift
class Dog {
	weak var delegate: 반려동물소유?
	...
	func passData(_ 이름: String) {
		delegate?.매소드(이름)
	}
	...
}
```

도식화하면 다음과 같습니다.
![Dog는델리게이트를생성해서사용](https://user-images.githubusercontent.com/65879950/129724181-a8963678-f903-4e43-97dc-26319d186e92.jpeg)

프로토콜에 선언한 프로퍼티나 메소드는 다음과 같이 나타냅니다.
![프로토콜세부구현](https://user-images.githubusercontent.com/65879950/129724192-7a38ceca-8d4b-4d70-b017-9efc5c08db2b.jpeg)
<br/><br/>
### 정리
지금까지 그렸던 도식들을 총 정리해서 표현하면 다음과 같습니다.
![클래스다이어그램총정리](https://user-images.githubusercontent.com/65879950/129724195-6f8ee4c1-247c-41f8-90f8-070c2be75791.jpeg)

<br/><br/>
## 결론
이번 글은 결론지을 내용은 없어서 개인 생각을 작성합니다.
클래스 다이어그램을 이용하는 것에 대한 장점이 많이 있습니다.

앱을 구현할 때, 이렇게 미리 작성해둔다면 중간에 엎어버릴 확률이 줄어듦니다.
~~정말로~~

그리고 해당 내용을 공유할 때도 용이합니다.

나중에 내가 코드를 봐서 이해해도 좋지만, 미리 작성해둔 클래스 다이어그램이 있다면 좀더 이해하기도 쉽구요.

그래서 좋은 도구이니 자신이 만들어둔 프로젝트를 다이어그램으로 해보시면서 익숙해지는 걸 추천드립니다~!
