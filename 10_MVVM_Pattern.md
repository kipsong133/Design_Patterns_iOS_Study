## MVVM에 대하여
MVVM 패턴.

> M(Model) - V(View) - VM(ViewModel) 로 구성된 아키텍처 패턴으로 비즈니스로직과 프리젠테이션 로직을 UI로 부터 분리한 패턴입니다.

클래스 다이어그램을 보겠습니다.

![](https://images.velog.io/images/kipsong/post/c4b42439-dea0-4c20-a18b-12e876a58b7f/MVVM%E1%84%91%E1%85%A2%E1%84%90%E1%85%A5%E1%86%AB_%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%84%89%E1%85%B3%E1%84%83%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A5%E1%84%80%E1%85%B3%E1%84%85%E1%85%A2%E1%86%B7.jpeg)


1. `Models` 는 앱의 데이터입니다. 보통 struct나 간단한 class로 구성하죠.
2. `Views` 는 UI요소를 스크린에 보여줍니다. `UIView`를 서브클래싱하는게 보통입니다.
3. `ViewModels` 는 Model (모델)을 값으로 변경하고, 그걸 View에 보여줍니다. 보통은 class로 구성합니다.

MVC 패턴에 비해 View Controller의 역할을 축소되었습니다. 

MVC 프로젝트를 MVVM으로 리팩토링하면서 개념을 익혀나가겠습니다.
<br/><br/>


## 언제 MVVM을 사용하지?
모델을 하나 이상의 뷰로 나타내고자 할 때, 사용하면 유용합니다.
~~물론 상황에 따라서 그냥 M-V-VM 을 1:1:1 매칭시키기도합니다.~~

뷰모델의 예를 들자면,

뷰모델을 사용해서 Date 타입의 데이터를 String으로 변경하고 있습니다.
또 10진수 데이터를 String으로 변경해주고 있죠.
이런식으로 데이터처리로직을 담당하는게 뷰모델입니다.

MVVM 패턴은 MVC 패턴의 단점을 잘 커버해줍니다.

만약 뷰모델이 없는 경우를 생각해봅시다. 

그러면 위에서 `Date -> String`, `10진수 -> String` 코드가 `viewDidLoad` 에서 처리해야할 겁니다.

그리고 View -> Model 방향의 데이터전댤은 IBAction이 담당하겠죠.

바로 위에서 말했던 로직을 뷰모델이 맡기면 코드의 역할분리가 깔끔해집니다.

위와 같은 MVC 상태를 “Massive ViewController” 라고 칭합니다.
~~뭐 코드가 Controller에 너무 많다는 걸 의미하겠죠.~~

예제를 통해서 좀 더 알아보죠.
<br/><br/>


## Example
MVVM 중에서
모델(Model) 을 먼저 구현하겠습니다.

참고로 해당 예제는 Playground에서 작성되었으므로 아래 라이브러리를 import 합니다.
```swift
import PlaygroundSupport
import UIKit
```


```swift
//MARK: - Model
// 모델을 정의한다.
public class Pet {
    // 특정값 enum으로 정의한다.
    public enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }
    
    // 모델의 멤버변수를 정의한다.
    public let name: String
    public let birthday: Date
    public let rarity: Rarity
    public let image: UIImage
    // 초기화 함수를 정의한다.
    public init(name: String,
                birthday: Date,
                rarity: Rarity,
                image: UIImage) {
        self.name = name
        self.birthday = birthday
        self.rarity = rarity
        self.image = image
    }
}
```

기존에 작성하는 Model이죠? MVVM이라고 특별한 건 없습니다.

다음으로 뷰모델 (ViewModel)을 작성하겠습니다.

```swift
//MARK: - ViewModel
// 뷰모델을 정의한다.
public class PetViewModel {
    
    private let pet: Pet // Model 데이터를 저장할 프로퍼티
    private let calendar: Calendar
    // 초기화 함수를 통해 model 데이터를 전달받는다.
    public init(pet: Pet) {
        self.pet = pet
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    // 연산프로퍼티를 활용해 데이터의 이름을 출력한다.
    public var name: String {
        return pet.name
    }
    // 연산프로퍼티를 활용해 이미지를 출력한다.
    public var image: UIImage {
        return pet.image
    }
    // 나이에 대한 값을 출력하는 연산프로퍼티를 정의한다.
    public var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: pet.birthday)
        let components = calendar.dateComponents([.year],
                                                 from: birthday,
                                                 to: today)
        let age = components.year!
        return "\(age) years old"
    }
    
    // enum의 종류에 따라 분기문 처리를 한 후 String을 출력한다.
    public var adoptionFeeText: String {
        switch pet.rarity {
        case .common:
            return "$50.00"
        case .uncommon:
            return "$75.00"
        case .rare:
            return "$150.00"
        case .veryRare:
            return "$500.00"
        }
    }   
}
```


주석 이 외에 코드 세부사항에 대한건 특별한 건 없습니다.

다만 이곳에 있는 코드들의 속성에 주목해야하죠.

모델의 값을 하나 받아오죠. 그리고 그 모델 값에 대한 세부 프로퍼티를 연산 프로퍼티로 출력하고 있습니다.

출력하는 과정에서 로직이 필요하다면 코드블럭 내에서 연산한 후 return 하는 클로저를 구성하고 있습니다.

이렇게 뷰모델을 구성했다면, 뷰와 뷰모델을 연결해야 겠죠?

```swift
extension PetViewModel {
    // viewModel을 생성하는 메소드를 정의한다.
    public func configure(_ view: PetView) {
        view.nameLabel.text = name
        view.imageView.image = image
        view.ageLabel.text = ageText
        view.adoptionFeeLabel.text = adoptionFeeText
    }
}
```


`configure` 메소드를 통해서 연결합니다.

이 부분은 프로그래머마다 다를 수 있습니다.
이 부분을 ViewController에서 처리하시는 분도 계시고, 이렇게 뷰모델 내 에서 처리하기도 하죠.

지금같은 경우 View 하나니까 이렇게 파라미터도 하나만 있는 겁니다.

보통 ViewController 에 있는 UIView 클래스들은 상당히 많습니다.

이에 대해서 ViewModel로 가져와서 이를 처리해도 되구요. ViewController ViewDidLoad 에서 처리해도 결과는 똑같습니다.

다만 코드의 가독성차이가 나겠죠.

이 부분에서 어떤분들은 ViewModel에 코드가 너무 많아서 Mass ViewModel 이라고 조롱섞인 말투로 말하기도 합니다. 
~~그래도 MVC보다는 더 깔끔합니다.^^;~~

여기까지 작성한 걸 정리하자면,

데이터를 어떻게 구성할지 정했습니다. (Model)
그리고 그 데이터를 어떻게 가공할지 결정했습니다. (ViewModel) 추가로 이를 UI에 추가할 메소드까지 만들었죠.

앞으로는 UIView를 생성하고 데이터를 받기만하면 끝입니다.

이부분은 특별한 부분이 없으니 간략히 코드만 보고 넘어갈게요.

```swift
public class PetView: UIView {
    
    public let imageView: UIImageView
    public let nameLabel: UILabel
    public let ageLabel: UILabel
    public let adoptionFeeLabel: UILabel
    
    public override init(frame: CGRect) {
        
        var childframe = CGRect(x: 0,
                                y: 16,
                                width: frame.width,
                                height: frame.height / 2)
        
        imageView = UIImageView(frame: childframe)
        imageView.contentMode = .scaleAspectFit
        
        childframe.origin.y += childframe.height + 16
        childframe.size.height = 30
        nameLabel = UILabel(frame: childframe)
        nameLabel.textAlignment = .center
        
        childframe.origin.y += childframe.height
        ageLabel = UILabel(frame: frame)
        ageLabel.textAlignment = .center
        
        childframe.origin.y += childframe.height
        adoptionFeeLabel = UILabel(frame: childframe)
        adoptionFeeLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(adoptionFeeLabel)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(corder:) is not supported")
    }
    
}
```

이제 호출해보겠습니다.

```swift
// 생일 계산 프로퍼티
let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
// 이미지 프로퍼티
let image = UIImage(named: "stuart")!
// 모델을 준수하는 프로퍼티를 생성한다.
let stuart = Pet(name: "Stuart",
                 birthday: birthday,
                 rarity: .veryRare,
                 image: image)

// 2 뷰모델을 생성하고 그곳에 모델을 할당한다.
let viewModel = PetViewModel(pet: stuart)

// 3 UI 위치
let frame = CGRect(x: 0, y: 0, width: 300, height: 420)
let view = PetView(frame: frame)

// 4 뷰모델과 view를 연결하는 메소드를 호출한다.
viewModel.configure(view)

// 5 UI에 띄운다.
PlaygroundPage.current.liveView = view
```


MVC와 다른 부분은 이부분입니다.
`viewModel.configure(view)` 
뷰모델의 데이터를 통해 view를 나타내는 부분이죠
<br/><br/>


## MVVM 유의사항
MVVM은 개인적으로 MVC보다는 장점이 더 많다고 생각합니다.
- 코드가독성 (훠어러얼씬)
- 뷰모델의 재사용 가능성

하지만, MVC가 좋은점도 있죠.

열심히 프로젝트를 진행하는데 요구사항이 변경된다면, MVVM은 많은 수고를 거쳐서 코드를 수정해야할겁니다.
~~Model 바꾸고, ViewModel 바꾸고 View 바꾸고~~

그에 비해 MVC는 좀 단순하죠.

그냥 Viewcontroller 가서 일부 로직만 휙하고 바꾸면 됩니다.

개인적으로는 MVC로 기능테스트를 해보고 MVVM으로 코드를 분리하는게 두 가지 패턴의 장점을 모두 활용하는 방법이 아닐까.. 생각해봅니다.

## 정리

Q. MVVM의 구성요소는 무엇이고 각각은 어떤 역할을 하는가?
Q. Model과 View는 어떻게 ViewModel을 통해서 어떻게 연결하는가?

에 대한 대답을 할 수 있도록 글을 구성했습니다.



읽어주셔서 감사합니다.
