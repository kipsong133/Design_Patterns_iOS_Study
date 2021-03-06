
# 1. What are Design Patterns?
![김밥사진](https://user-images.githubusercontent.com/65879950/129715772-6f94db32-308b-47bb-9569-daa5d87759f6.jpg)
(이미지 출처: https://unsplash.com/photos/iIS1SIO5_aY?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink)
<br/><br/>
## 신입: 두렵다… 디자인 패턴…


신입들은 “디자인 패턴” 이라는 말만 들어도 무서워합니다.
~~무섭다.~~

하지만, 모두 알고 있죠. “A better Programmer” 라면, 
디자인패턴은 필수 지식이라는 사실이요.

그래서 이 책을 읽는 것이고, 제 글을 읽으시는 거겠죠?
<br/><br/>
<br/><br/>
## 현실에 있는 문제를 해결


프로그래밍을 하다보면, 많은 버그들 혹은 “문제” 들이 정의되죠.

그러한 문제들의 공통점을 추리고 다양한 문제에 대한 해결책으로 

집약된 결정체가 “디자인 패턴” 이라고 보시면 됩니다. 그래서 하나의 플랫폼에 갇혀있지 않죠.
다른 플랫폼에서 해결한 디자인 패턴이라면 iOS에서도 적용될 가능성이 있습니다.

디자인 패턴이 현실에 사용된 예시를 들어보겠습니다.

지금 독자는 “김밥을 만드는 요리사” 입니다.

현재 직원은 총 3 명입니다.

주문이 들어오면, 돌아가면서 밥먹고 김밥을 만들고 설거지를 하곤 해왔습니다.
딱히 역할을 나누지 않고 모두가 모든 일을 나눠서 합니다. 문제없이 잘해왔습니다.

그런데 어떤 인플루언서가 김밥집을 다녀간 이후, 엄청난 손님들이 몰려오기 시작했습니다.

평균 하루에 10줄 만들던 김밥집이 갑자기 1천 줄을 만들어야 합니다. 그것도 1시간에요.

여기서 해결책은 무엇일가요? 

네, 맞습니다. 먼저 사람을 더 고용해야겠죠. 그런데 그 해결책과 더불어 “효율성 개선” 도 필요할 겁니다.

인류는 효율성 개선을 시도했던 역사적인 사례가 있습니다.

바로 **산업혁명** 입니다.

산업혁명의 속성을 두 가지만 이야기하라면,
1. 분업화
2. 전문화
입니다.

그래서 김밥집에도 이 “패턴” 을 적용합니다.

3 명을 분업화 하고 각자의 업무를 전문화 하여 생산성을 극대화 합니다.

1 명은 김밥에 들어갈 기반이 되는 양념된 밥만 만듭니다.
1 명은 깁밥에 들어갈 재료만 만듭니다.
마지막 1 명은 김밥을 조립해서 완성합니다.

그런데 이렇게 분업화와 전문화만 해도 1천줄을 한시간에 못만드는 겁니다.

그러면 이제 “도구”를 도입할 시점 입니다.

김밥을 손으로 마는 것이 아니라. 재료 넣고 “롤”을 돌리기만하면 만들어지는 도구를 도입합니다.

그 도구 사용법이 어렵다고 가정해봅시다.

그러면 3 명 모두 배워야겠죠? 그래서 새로운 도구를 도입하는 것은 언제나 피곤한 일입니다.

하지만 그 도구를 이용하지 않으면 생산성에 한계가 있습니다.

그래서 그 도구를 도입하죠.

이런식으로 각자의 분업과 전문화에 곱셈을 해줄 도구를 도입하곤 합니다.

디자인 패턴도 마찬가지입니다.

각자의 코드의 역할을 분리하고 전문화합니다. 그리고 그곳에 라이브러리라는 도구를 통해 퍼포먼스를 향상시키거나 코드가독성을 향상시키죠.

이처럼 “디자인 패턴”은 특별한 개념이 아닙니다.

현실에서도 문제를 해결하는 원리에 디자인 패턴 개념이 녹아 있습니다.
(물론 1:1 매칭이 완벽히 되는 건 아니지만요.)

<br/><br/>
<br/><br/>
## 디자인 패턴의 종류

디자인 패턴에 대해서 자세히 보기 전에 분류를 먼저 해보겠습니다.

1. 구조 패턴 (Structural Pattern)
2. 행동 패턴 (Behavioral design pattern)
3. 생성 패턴 (Creational Pattern)
~~정보처리기사에서 들어보지 않았나요?^^~~

	- 구조 패턴은 “어떻게 객체를 구성하고 연결할지” 에 관심이 있습니다. 예를 들면, MVC, MVVM 그리고 Facade 패턴이 있습니다.
	- 행동 패턴은 “객체들이 어떻게 소통할지” 에 관심이 있습니다. 예를 들면 Delegation, Strategy 그리고 Observer 가 있습니다.
	- 생성 패턴은 “객체들의 인스턴스를 어떻게 생성할지” 에 관심이 있습니다. 예를 들면 Builder, Singleton 그리고 Prototype 이 있습니다.

자세한 내용은 이후 글을 통해서 설명하겠습니다.

<br/><br/>
<br/><br/>
## 디자인 패턴을 사용하면 좋은 점

- 디자인 패턴은 **공용어**이다.
-> 맞습니다. 디자인 패턴은 특정 프로그래밍 언어에 국한되지 않죠. 그렇기 때문에 개발자끼리 의사소통에 도움이 됩니다.

- 디자인 패턴은 프로젝트를 이해하는 지름길이 되어준다.
-> 새로운 프로젝트를 전달받았는데, 그 디자인 패턴이 이미 아는 패턴이라고 가정해봅시다. 그러면 해당 프로젝트를 독해하는데 시간이 줄어들겠죠. 그리고 유지보수도 쉬울 겁니다.

- 디자인 패턴은 더 좋은 프로그래머로 만들어준다.
~~몸값을 올려준다.~~
-> 당연한 소립니다. 공부를 더하고 그것이 직무연관성이 깊다면, 당연히 더 좋은 개발자로 만들어주죠. 몸값은 덤입니다.

- Knowing design patterns allow you to spot similarities between code.
(마지막 말은 감명 깊어서 그대로 옮겨옵니다.)
-> 전 이말에 상당히 동의합니다. 내가 특정 디자인 패턴을 이해하고 그 디자인패턴으로 구성된 다른 프로젝트를 볼 때, 시야가 넓어집니다. 그리고 배움의 기회가 더 많아집니다.
같은 패턴이라도 프로그래머마다 이해하는 수준이 다르고 구현이 조금씩 다를 수 밖에 없겠죠.
그 차이점을 보면서 성장하는 것이 정말 빠르게 성장하는 길이더라구요.
~~경험상 그렇다는 겁니다. 객관화 할 수 있는 부분은 아닙니다.~~

<br/><br/>
<br/><br/>
## 결론

~~디자인 패턴은 **킹왕짱**이다.~~

	- 디자인 패턴은 코드를 작성하는 시작점이 되어준다.
	- 디자인 패턴은 코드를 이해하는 시작점이 되어준다.
	- 디자인 패턴은 3 종류로 분류할 수 있다.
	- 디자인 패턴은 몸값을 올려준다.

이상 정리 끗.
