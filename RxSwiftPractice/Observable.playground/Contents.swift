import Foundation
import RxSwift


// MARK: - Observable 시퀀스 생성하기

// .just -> 하나의 요소를 방출하는 옵저버블 시퀀스 생성
Observable<Int>.just(1)
    .subscribe(onNext:{ // onNext 요소 출력하기
        print($0)
    })

// .of -> 여러개의 요소를 방출하는 오저버블 시퀀스 생성
Observable<Int>.of(1,2,3,4)
    .subscribe({ // onNext를 안쓰면 completed 까지 출력된다.
        print($0)
    })


// .from -> 콜렉션 형태의 element만 받는다.
// 콜렉션 형태인지 array인지 확인하기;;;
Observable.from([1,2,3,4,5])
    .subscribe({
        if let element = $0.element{ // onNext와 동치
            print(element)
        }
    })

// empty ->
Observable<Any>.empty()
    .subscribe({
        print($0)
    })
print("asdf")

// MARK: - disposeBag : dispose를 담는 컨테이너
// dispose : 사용 완료하고 버리기 할당해제

// Observable은 타입추론을 통해 element를 방출한다. 따라서 아래코드는 배열 하나를 방출한다.

// 만약 dispose를 빼먹으면 메모리 누수 발생,
// depose가 되기 전에 해당 VC가 할당해제되면... 메모리 누수

let disposeBag = DisposeBag()

Observable.of([1,2,3,4])
    .subscribe(onNext:{
        print($0)
    }).disposed(by: disposeBag)
// 가방에 담고있다가 자기가 할당 해제될때 담고있는 disposable객체들을 전부 dispose한다.




//MARK: - create :

enum SampleError: Error {
    case anError
}
Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(SampleError.anError) // 여기까지만 출력됨. 에러뜨면 종료
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
},
           onError: {
    print($0.localizedDescription)
},
           onCompleted: {
    print("completed!")
},
           onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)


//MARK: - deffered
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

var char: Bool = true
let factory: Observable<String> = Observable.deferred {
    char.toggle()
    if char {
        return Observable.of("@")
    }else {
        return Observable.of("#")
    }
}
for _ in 0...3{
    factory.subscribe(onNext: {
       print($0)
    }).disposed(by: disposeBag)
}
