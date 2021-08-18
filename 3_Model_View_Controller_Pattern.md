![MVC패턴섬네일](https://user-images.githubusercontent.com/65879950/129825141-07a4c869-ae92-45a3-b353-b589e0dd49b7.jpeg)

<br/><br/>
## MVC에 대한 전반적인 설명
MVC 패턴은 3 가지 타입으로 나눈 패턴입니다.
1. Model
2. Controller
3. View

MVC를 클래스 다이어그램으로 표현하면 다음과 같죠.
![MVC클래스다이어그램](https://user-images.githubusercontent.com/65879950/129825131-7e758262-6ba0-4dde-9e65-b089dd2d1293.jpeg)



- Model은 애플리케이션의 데이터를 담고 있습니다. 보통 “구조체(struct)” 나 “클래스(class)” 로 정의합니다.
- Views는 시각요소들(버튼이나 레이블)을 스크린에 보여주는 역할을 합니다. 보통 UIKit에서는 UIView를 서브클래싱하고 있는 객체들이죠.
- Controllers는 `Model` 과 `View`의 중간에 위치해 있으면서 둘의 소통을 돕습니다. 보통 UIKit에서 UIViewController의 서브클래싱하고 있는 객체들입니다.

iOS에서 MVC 패턴은 아주 익숙합니다. 왜냐하면 Apple에서 UIKit의 구조패턴으로 선정했기 때문입니다. 그래서 그에 맞게 객체들도 구성되어 있습니다.

컨트롤러가 모델과 뷰에 대한 프로퍼티를 모두 가지고 있기때문에, 이 둘에 직접적으로 접근할 수 있습니다. 이로인해 둘 간의 소통이 잘 되구요.
```swift
class ViewController: UIViewController {

	var dataModel: ViewControllerModel?

	@IBOutlet weak var label: UILabel!
	...
	override func viewDidLoad() {
		super.viewDidLoad()
		label.text = dataModel?.text ?? "Uno"
	}
	...
}
```

코드로 아주 간단히 작성해봤는데, 이런 구조로 정의되겠죠.
각 컨트롤러에 멤버변수로 Model과 UILabel을 가지고 있고,
이 둘을 생명주기 메소드 내에서 컨트롤하고 있죠.

자세히 보시면, 설명안한 부분이 있습니다.

모델과 뷰는 강한참조를 가지지 않도록 합니다.
이유는 “강한 순환참조(Strong Reference Cycle)” 문제 때문인데요. 이 부분은 나중에 자세히 다루겠습니다.

일단 “메모리관리에 관련된 이슈가 있고 이를 해결하기 위해서 “weak” 를 사용해서 문제를 해결하곤 한다.” 정도로 이해하시면 될 것 같습니다.

애니웨이.

모델은 컨트롤러와 소통하기 위해서 “프로퍼티 옵저버”를 활용합니다.
뷰는 컨트롤러와 소통하기 위해서 InterfaceBuilder를 이용하고요.
<br/><br/>
## 언제 이걸 사용하지?
UIKit으로 iOS 앱을 구현하면, 이미 적용되어 있습니다.

간단한 Playground example로 이해해보겠습니다.

먼저 이전 단원에서 언급했던 디자인패턴 3 가지 생각나시나요?
1. 구조 패턴
2. 행동 패턴
3. 생성 패턴

그 중에서 MVC는 구조패턴입니다. 
그렇기 때문에 “어떻게 객체의 시스템을 구성할지”에 관심이 있습니다.
<br/><br/>


### Model
먼저 모델코드를 보겠습니다.
```swift
//MARK: - Address
public struct Address {
    public var street: String
    public var city: String
    public var state: String
    public var zipCode: String
}
```

아주 간단합니다. 구조체를 “Address” 로 정했고, 멤버변수로 “street”, “city”, “state”, 그리고 “zipCode”라고 선언했습니다.


<br/><br/>
### Views
다음은 Views 입니다.
```swift
//MARK: - AddressView
public final class AddressView: UIView {
    @IBOutlet public var streetTextField: UITextField!
    @IBOutlet public var cityTextField: UITextField!
    @IBOutlet public var stateTextField: UITextField!
    @IBOutlet public var zipCodeTextField: UITextField!
}
```

UIView를 상속받는 “AddressView” 라는 클래스에 멤버변수로 4 가지 UITextField가 선언되어 있습니다.

지금 예시는 playground이지만 실제 앱 프로젝트로 구성하게 되면 `xib` or `storyboard` 로 구현할 수도 있죠.

addressView와 4 개의 UITextField가 소통하기 위해서 @IBOutlet으로 소통하고 있네요.


<br/><br/>
### Controllers
그리고 컨트롤러 코드입니다.

```swift
// MARK: - AddressViewController
public final class AddressViewController: UIViewController {
  // MARK: - Properties
  public var address: Address?
  public var addressView: AddressView! {
    guard isViewLoaded else { return nil }
    return (view as! AddressView)
  }
	... (생명주기 함수나 이 외 메소드들) ...
}
```

“AddressViewController” 가 UIViewConroller를 상속받고 있네요. `Controller`
그리고 “address” 라는 이름의 `Model` 이 선언되어 있습니다.
그 바로 아래 줄 “addressView” 라는 이름의 `View` 가 있습니다.
그리고 연산프로퍼티(Computed Property)로 특정 조건일 때, 자신을 리턴하도록 선언했네요.

지금은 뷰와 모델이 서로 소통하지 못하는 형국입니다.

이 둘을 어떻게 소통시킬 수 있을까요?

UIViewController에서는 이를 생명주기 함수를 통해서  할 수 있습니다.
(물론 다양한 방법이 있지만요.)

AddressViewController 내부에 있는 `viewDidLoad()` 와 `updateViewFromAddress()` 메소드를 보겠습니다.

```swift
// MARK: - View Lifecycle
public override func viewDidLoad() {
  super.viewDidLoad()
  updateViewFromAddress()
}

private func updateViewFromAddress() {
  guard let addressView = addressView,
    let address = address else { return }
  addressView.streetTextField.text = address.street
  addressView.cityTextField.text = address.city
  addressView.stateTextField.text = address.state
  addressView.zipCodeTextField.text = address.zipCode
}
```

address값이 있다면, viewDidLoad 호출 시점에 View에 값들이 할당되면서 UI가 업데이트 될 것입니다.
(address(Model)에 있는 데이터가 addressView(View)에 전달되어 UI를 업데이트한다.)

그런데 지금은 view가 메모리에 할당될 시점에만 UI가 업데이트 되죠.

만약에 Model 인 address 값이 변경된다면 어떨까요?

이미 메모리에 할당되어있기 때문에 UI는 변경되지 않습니다.

이 문제를 해결하기 위해서(UI와 데이터 동기화) 프로퍼티 옵저버를 사용합니다.

코드를 보겠습니다.

```swift
public var address: Address? {
  didSet {
    updateViewFromAddress()
  }
}
```

보시면 `didSet` 이라는 친구가 있고, 해당 코드블럭에 보면

이전에 선언했던 메소드가 들어가 있죠.

didSet = “~을 set  한 뒤 {…} 를 실행한다.” 라고 받아들이시면 됩니다.

그러니까 address에 set 했다는 건 데이터가 들어왔다는 뜻이죠.

> 그러므로 address에 데이터가 입력되면, didSet의 코드블럭을 실행한다.

입니다.

이제 View 와 Model이 Controller에서 연결되었습니다.
어떤걸 통해서요?

-> 바로 프로퍼티 옵저버를 통해서~!

그런데 잘 생각해보면 지금은 방향이 단방향입니다.

`모델에서 값이 변경 -> (컨트롤러) -> 뷰의 UI를 변경`

그러면 역방향으로 진행되면 어떻게 될까요?

`뷰에서 값 사용자에가 값을 받아옴 -> (컨트롤러) -> 모델의 값을 변경`

위와 같은 순서인 경우 말이죠.

결론먼저 말씀드리면, UIKit에서는  `@IBAction` 를 사용해서 변경할 수 있습니다.

~~swiftUI의 경우는  @State 로 선언한 변수랑 view를 연결해서 직접 소통합니다.(이 부분은 MVC 패턴설명에 관련 없으므로 나중에 MVVM에서 설명하겠습니다.)~~

`updateViewFromAddress()` 메소드 아래 @IBAction 메소드를 구현하겠습니다.

```swift
// MARK: - Actions
@IBAction public func updateAddressFromView(
  _ sender: AnyObject) {
  
  guard let street = addressView.streetTextField.text, 
    street.count > 0,
    let city = addressView.cityTextField.text, 
    city.count > 0,
    let state = addressView.stateTextField.text, 
    state.count > 0,
    let zipCode = addressView.zipCodeTextField.text, 
    zipCode.count > 0 else {
      // TO-DO: show an error message, handle the error, etc
      return
  }
  address = Address(street: street, city: city,
                    state: state, zipCode: zipCode)
}
```

위 코드를 보면,

컨트롤러 내에 @IBAction 메소드를 선언했습니다. 그리고 이것은 현재 View와 연결되어 있습니다. (그러면 Controller - view 가 연결되어있는 상태겠죠.)

그리고 메소드 내부에서는 address(모델) 에 값을 할당하면서 모델과 뷰가 연결되어 있습니다.

위에서 말씀드렸던 로직이 완성된 거죠
`View(addressView) -> Controller(IBAction) -> Model(address)`


<br/><br/>
## MVC에서 고려해야할 사항들
MVC 패턴은 처음에 시작하기 좋은 구조패턴입니다.
그리고 직관적이죠.

컨트롤러 내에 모든게 있습니다.
마치 컨트롤러가 주방의 도마같아요.

재료(모델) 이 있고 
칼질(로직)해서 그걸 국통(뷰)에 넣죠.

그 과정을 하나의 Controller 파일에서 볼 수 있습니다.

문제는 여기서 발생합니다.

`하나의 Controller` 에서 모두 볼 수 있다.
== Controller에 너무 많은 코드와 역할이 부여된다.

그래서 이 문제 혹은 어려움을 “Massive View Controller” 라고 칭합니다.
(유튜브나 많은 블로그 글에서 사용하는 용어니 한 번쯤 눈에 담아 주세요.)

그래서 iOS 개발자들은 더 나은 패턴을 찾아 여행을 시작하게되죠. 
