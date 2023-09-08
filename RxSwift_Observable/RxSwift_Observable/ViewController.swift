//
//  ViewController.swift
//  RxSwift_Observable
//
//  Created by 오동규 on 2023/01/12.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var disposeBag: DisposeBag = DisposeBag()
      
      override func viewDidLoad() {
        super.viewDidLoad()
        
        checkArrayObservable(items: [4, 3, 1, 5, 2]) // subscribe메소드 : next, error, completed를 구독 및 관찰하다가 해당 값을 배출하게 되면 값을 pirnt 한다.
          .subscribe { event in
            switch event {
            case .next(let value):
              print(value)
            case .error(let error):
              print(error)
            case .completed:
              print("completed")
            }
          }
          .disposed(by: self.disposeBag)
      }
      
      func checkArrayObservable(items: [Int]) -> Observable<Int> { // items 정수타입의 배열을 받음 -> 정수 제네릭 타입의 Observable 객체 리턴
        return Observable<Int>.create { observer -> Disposable in // create 메소드 : observer을 파라미터로 받고 Disposable 객체를 리턴하는 클로저 입력받는다.
          
            // onserver의 메소드. onNext, onError, onCompleted
          for item in items {
            if item == 0 {
              observer.onError(NSError(domain: "ERROR: value is zero.", code: 0, userInfo: nil))
              break
            }
            
            observer.onNext(item)
            
            sleep(1)
          }
          
          observer.onCompleted()
          
          return Disposables.create()
        }
      }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    enum Event<T> {
//        case next(T)
//        case error(Swift.Error)
//        case completed
//    }
//
//
//
//
//    Observable<Int>.create { (observer) -> Disposable in
//
//        observer.on(.next(0))
//        observer.onNext(1)
//
//
//        observer.onCompleted()
//
//        return Disposables.create()
//    }
//
//    Observable.from([0, 1])
//
//
}

