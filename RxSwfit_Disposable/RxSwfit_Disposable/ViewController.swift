//
//  ViewController.swift
//  RxSwfit_Disposable
//
//  Created by 오동규 on 2023/01/12.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }
    
    deinit {
        print("deinit ViewController")
    }
    
    func test() {
        // observable 생성
        let observable = Observable<Int>.create { (observer) -> Disposable in
            observer.onNext(1)
            observer.onCompleted()
            return Disposables.create()
        }
        
        
        
        // just로 observable 생성
        let justObservable = Observable.just(1).subscribe{print($0)}
        
        
        
        // from으로 observable 생성
        let fromObservable = Observable.from([1, 2, 3]).subscribe{print($0)}
        
        
        
        // of 각각의 원소 방출(from처럼) <-> 배열 : 한번에 방출
        let ofObservable1 = Observable.of(1,2,3).subscribe{print($0)}
        let ofOBservable2 = Observable.of([1,2,3]).subscribe{print($0)}
        
        
        
        // map : 원하는 값으로 변형해서 방출시켜줌
        let transformMap = Observable.from([1,2,3]).map{$0*2}.subscribe{print($0)}
        
        
        
        // flatMap : Observable Stream을 새로 방출시켜줌
        let observableInt = Observable.of(1,2,3)
        let observableString = Observable.of("A", "B", "C")
        
        observableInt
            .flatMap { (x: Int) -> Observable<String> in
                return observableString
                
            }
            .subscribe {
                print("\($0)")
            }
    
        
        // scan : 이전에 방출된 결과와 새롭게 방출된 결과를 합쳐서 방출
        let scanTransform = Observable.of(1,2,3).scan(0){$0+$1}.subscribe{print($0)}

        
        // filter : 원하는 조건에 참인 것만 걸러줌
        let filter = Observable.from([1,2,3]).filter{$0 == 2}.subscribe{print($0)}
        
        
        // first : 방출한 결과 중 첫번째
        let first = Observable.from([1,2,3]).first().subscribe{print($0)}
        
        
        // takeLast : 끝에서 몇번째까지 방출할지 결정 <-> take (앞에서부터)
        let takeLast = Observable.from([1,2,3]).takeLast(2).subscribe{print($0)}
        
        
        // elementAt : 인덱스 번호 방출
        let elementAt = Observable.from([1,2,3]).element(at:2).subscribe{print($0)}
        
        
        // merge : 두 스트림 -> 하나의 스트림으로
        let observableInt3 = Observable.of(1,2,3)
        let observableInt4 = Observable.of(4,5,6)
        let merge = Observable.of(observableInt3, observableInt4).merge().subscribe{print($0)}

        
        // combineLatest : 두 스트림의 가장 최근 값끼리 합쳐서 하나의 값으로
        let observableInt5 = Observable.of(1,2,3)
        let observableString2 = Observable.of("A", "B", "C")
        let combineLatest = Observable.combineLatest(observableInt5, observableString2){"\($0)"+$1}.subscribe{print($0)}
        
        
        // zip : 짝이 맞아야 방출해줌
        let zip  = Observable.zip(observableInt5, observableString2){"\($0)"+$1}.subscribe{print($0)}
    }
    
    
    
    
    
    
    
    
//    var disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//      super.viewDidLoad()
//
//      test()
//    }
//
//    deinit {
//        print("deinit ViewController")
//    }
//
//    func test() {
//        let disposable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) // dispose 메소드 호출 -> 리소스 해제
//          .take(10)
//          .subscribe(onNext: { value in
//            print(value)
//          }, onError: { error in
//            print(error)
//          }, onCompleted: {
//            print("onCompleted")
//          }, onDisposed: {
//            print("onDisposed")
//          })
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            disposable.dispose()
//        }
//
//
////        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
////        .take(10)
////        .subscribe(onNext: { value in
////            print(value)
////        }, onError: { error in
////            print(error)
////        }, onCompleted: {
////            print("onCompleted")
////        }, onDisposed: {
////            print("onDisposed")
////        })
////        .disposed(by: disposeBag) // 모든 disposable 객체에 disposed 를 해주면 해당 파라메터인 disposeBag에 등록이 되고 disposeBag 객체가 해제 되면서 등록된 모든 disposable이 다같이 dispose 된다.
////
////      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////        UIApplication.shared.keyWindow?.rootViewController = nil // 3초 뒤에 뷰 컨트롤러 해제
////      }
//    }
//

}

