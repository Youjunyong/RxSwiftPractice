import RxSwift

let disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completed
}

//MARK: - Single
// 싱글
Single<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0)")
        },
        onDisposed: {
           print("disposed")
        })
    .disposed(by: disposeBag)

// asSignle()로 observer -> single
// 에러 상황 만들기
Observable<String>.create({ observer -> Disposable in
    observer.onError(TraitsError.single)
    return Disposables.create()
})
    .asSingle().subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0.localizedDescription)")
        },
        onDisposed: {
           print("disposed")
        })

//MARK: - JSON을 주고받는 네트워크 상황일때

struct SomeJson: Decodable{
    let name: String
}

enum JSONError : Error {
    case decodingError
}

let json1 = """
            {
            "name":"JY"
            }
            """

let json2 = """
            {
            "my_name":"kim"
            """

func decode(json: String) -> Single<SomeJson> {
    Single<SomeJson>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJson.self, from: data) else{
                  observer(.failure(JSONError.decodingError))
                  return Disposables.create()
              }
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1).subscribe { result in
    print(result)
}.disposed(by: disposeBag)

decode(json: json2).subscribe({ result in
    switch result{
    case .success(let json):
        print(json.name)
    case .failure(let error):
        print(error)
    }
    
}).disposed(by: disposeBag)

//MARK: - Maybe
Maybe<String>.just("🥸").subscribe(
    onSuccess: {
        print($0)
    },
    onError: {
        print("error: \($0)")
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("Disposed")
    })
    .disposed(by: disposeBag)


// MARK: - Completable
// Completable은  .asSingle() / .asMaybe 와 같은 메서드가 없다.
