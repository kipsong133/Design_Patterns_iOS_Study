

델리게이션의 뜻을 번역하면 다음과 같이 번역합니다.
> Delegation : 대표단, 파견단
> - Google 번역 -

결론먼저 말씀드리면, `delegation Pattern` 은 하나의 객체가 다른 객체를 도와줍니다. 데이터를 전달해주든 특정 task를 수행해주든 하는 방식으로요.

클래스 다이어그램으로 표현하면 다음과 같습니다.
![델리게이트클래스다이어그램](https://user-images.githubusercontent.com/65879950/129864912-f7829c54-2b66-4b5f-86e0-d3cc55126193.jpeg)



항목 하나씩 설명하겠습니다.
	- Object needing a delegate
		- “델리게이트를 필요로하는 객체” 로 해석할 수 있죠. 말 그대로 델리게이트를 이용하는 클래스입니다.( `weak vara delegate: 프로토콜?` 을 선언하는 클래스입니다.)

	- Delegate Protocol
		- 델리게이트 프로토콜의 멤버변수를 선언한 프로토콜입니다.

	- Object acting as a delegate
		- “델리게이트로써 활동하는 객체” 로 해석이 가능하죠. 델리게이트 프로토콜을 채택한 이후에 어떤 행동(task)를 할 지 구현하는 클래스를 의미합니다. (주로 `extension ViewController: 프로토콜` 을 구현하는 클래스가 되죠.)


iOS에서 특히나 UIKit에서 delegation pattern을 이용해서 많은 기능들을 사용하도록 하고 있습니다. (필수 공부 개념이라고 볼 수 있죠.)
<br/><br/>

### Delegate Pattern은 언제 사용하나요?

이 패턴은 다음과 같은 상황에서 사용되곤 합니다.
	- 거대한 클래스나 제네릭을 쪼개고 싶을 때 (가독성)
	- reusable 한 객체를 가져다 사용할 때  ex. UITableView (재사용성)
	- 다른 컨트롤러의 데이터를 전달하거나 특정 로직을 실행할 때 (데이터 전달)

~~옆에 괄호는 제가 생각하는 속성들을 정리한 겁니다. 공식적인 건 아니니 유의~~

이 중에서 “reusable한 객체를 가져다가 사용할 때” 에 대해서 좀 더 말해보고자 합니다.

~~이 글을 읽으실 정도면 최소한 UITableView는 구현해보셨을 것으로 추정됩니다. 그 전제하에 글을 작성합니다.~~

UITableview를 구현할 때, 구현하고자 하는 클래스에 두 가지 프로토콜을 채택합니다.
	1. UITableView`Delegate`
	2. UITableview`DataSource`

그런데 이런 의문이 들지 않나요?
> 어차피 프로토콜을 둘 다 채택하는데 하나로 만들면 안되는거야? 귀찮게 ㅡㅅㅡ

애플은 “계획”이 있었던 겁니다. 두 개로 나눈 이유는 다 있습니다^^

`DataSource` 가 붙은 프로토콜은 “provoding Data”에 집중된 메소드를 담고 있습니다. 즉, 데이터 전달 관련 프로토콜입니다.

`Delegate` 가 붙은 프로토콜은 “received data or events” 에 집중된 메소드를 담고 있습니다. 즉, 데이터를 받거나 이벤트를 처리하는 프로토콜입니다.

애플에서는 프로토콜을 만들 때, 위와 같은 접미사를 계속 사용하니, 암묵적으로 해당 프로토콜이 어떤 메소드 혹은 프로퍼티가 있는지 추론할 수 있겠죠.

궁금하신 분들은 UICollectionView도 확인해보세요.
<br/><br/>

## Playground Example

간단하게 playground 예제를 통해서 delegate pattern 을 보겠습니다.

예시로 사용할 컨트롤러는   `MenuController` 입니다. 그리고

 `MenuController` 는 테이블뷰를 가지고 있습니다. 그러면 `UITableviewDelegate` & `UITableviewDataSource` 프로토콜을 채택하고 있겠죠.

먼저 컨트롤러가 있고 그 컨트롤러에 테이블뷰를 구성하면 다음과 같이 구성하죠.
```swift
public class MenuViewController: UIViewController {
  
  public weak var delegate: MenuViewControllerDelegate?
  
  @IBOutlet public var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.delegate = self
    }
  }
  
  private let items = ["Item 1", "Item 2", "Item 3"]
}
```

컨트롤러가 UIViewController를 상속받고, 내부에는 tableView와 @IBOutlet으로 연결되어 있습니다. 그리고 프로퍼티옵저버를 통해서 각 `deleate` & `datasource` 를 `MemuController` 임을 지정하고 있습니다.
여기까지만 하면 클래스에서 프로토콜을 준수하지 않았다고하며 경고창이 뜨게됩니다.
그 부분은 바로 이어서 할 예정입니다.

`items` 는 테이블 뷰에 구성할 Array<String> 입니다. 

위 경고창을 제거하기 위해서 프로토콜을 채택하면 다음과 같이 구성됩니다.

```swift
// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "Cell",
                                      for: indexPath)
      cell.textLabel?.text = items[indexPath.row]
      return cell
  }
  
  public func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    // To do next....
  }
}
```

어려운 내용은 없습니다. 메소드의 파라미터를 하나씩 읽어보시면 다 이해될 내용이죠.
	- cellForRowAt : 셀을 어떻게 구성할 것인지
	- numberOfRowsInSection : 섹션에 몇 개의 셀을 구성할 것인지
	- didSelectRowAt : 셀을 클릭하면 어떻게 이벤트 처리할 것인지

이 글은 Delegate Pattern에 대한 글이므로 테이블 뷰에 대한 설명은 여기까지만 할게요.

“테이블 뷰를 클릭하면, cell의 정보를 다른 컨트롤러로 넘겨주고 싶다” 라고 가정하겠습니다.

그러면 전달하기 위해서 Protocol을 먼저 정해야겠죠.
```swift
public protocol MenuViewControllerDelegate: class {
  func menuViewController(
    _ menuViewController: MenuViewController,
    didSelectItemAtIndex index: Int)
}
```

프로토콜을 정의했으면 프로토콜을 상속받고 있는 프로퍼티를 통해서 호출해야합니다.

```swift
  public weak var delegate: MenuViewControllerDelegate?
```


클릭 이벤트 발생 시, delegate에서 구현했던 메소드를 호출해야하므로 `didSelect` 메소드에서 델리게이트 메소드를 호출합니다.

```swift
// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
    delegate?.menuViewController(self, didSelectItemAtIndex: indexPath.row)
  }
}
```

정리하면 다음과 같은 로직으로 진행될겁니다.

	1. 테이블 뷰의 셀을 클릭한다.
	2. 셀 내부에 있는 로직이 실행된다.
	3. `delegate?.menuViewController(self, didSelectItemAtIndex: indexPath.row)` 가 호출된다.
	4. delegate는 프로토콜을 따르고 있으므로 해당 프로토콜을 채택하고 있는 컨트롤러로 이동할 것이고 그 컨트롤러에서 로직이 진행될 것입니다.

여기까지 간단한 예제로 알아봤습니다.

만약 delegate Pattern이 처음에는 어떻게 동작하는지 알기 어려우실 겁니다. 몇 번 구현해보시면서 숙련도를 쌓다보면 역으로 원리가 이해되기도 하니 몇 번 해보세요.

아래 순서로 구현한다고 생각하시면 됩니다.

```
1. protocol을 선언한다.
2. 델리게이트가 필요한 시점에 delegate 프로퍼티를 선언하여 호출한다.
3. 대신 로직을 처리해줄 컨트롤러로 이동하여 프로토콜을 extension을 통해 채택하고 메소드나 프로퍼티를 구현한다.
4. 각각의 컨트롤러가 참고하고 있음을 나타내기 위해 delegate가 있는VC.delegate = self 를 통해 참고한다.
```
<br/><br/>

### 예제 : 이전 컨트롤러로 데이터를 전달하기

Q. 두 개의 컨트롤러가 있습니다. 
VC1 -> VC 2 로 화면이 modal을 통해 Transition 됩니다.
VC1에서는 UILabel만 있으며,
VC2 에서 UITextField를 통해서 텍스트를 입력받습니다.
VC2 에서 dismiss하면, VC1 에서는 VC2에서입력받은 UITextField의 text를 전달받아 UILabel에 나타냅니다.

UI에 대한 상세구현은 생략하고 코드만 나타내겠습니다.
(여기서 상세구현은 Autolayout 외 Attribute Inspector 값 설정을 생략하는 것을 뜻합니다.)
```swift
class VC1: UIViewController {
	@IBOutlet weak var label: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func nextButton(_ sender: UIButton) {
		let vc = VC2() 
		present(vc, animated: true)
	}
}
```


```swift
class VC2: UIViewController {
	@IBOutlet weak var textField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func valueChanged(_ sender: UITextField) {
		guard let text = sender.text else { return }
		// do something
	}

	@IBAction func nextButton(_ sender: UIButton) { 
		dismiss(animated: true)
	}
}
```

위 상태에서 구현을 시작하면 되겠습니다.

