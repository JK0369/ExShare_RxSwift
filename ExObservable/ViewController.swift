//
//  ViewController.swift
//  ExObservable
//
//  Created by 김종권 on 2023/04/04.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    private let viewDidAppearPublish = PublishSubject<Void>()
    var viewDidAppearObservable: Observable<Void> {
        viewDidAppearPublish
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observable = Observable<Int>.create { observer in
            print("observable created")
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            return Disposables.create()
        }.share(replay: 2)

        _ = observable.subscribe(onNext: { element in
            print("first subscription: \(element)")
        })

        _ = observable.subscribe(onNext: { element in
            print("second subscription: \(element)")
        })
        /*
         observable created
         first subscription: 1
         first subscription: 2
         first subscription: 3
         second subscription: 2
         second subscription: 3
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewDidAppearPublish.onNext(())
        
        _ = viewDidAppearPublish
            .subscribe(onNext: {
                print("first subscription, viewDidAppearPublish")
            })
        
        _ = viewDidAppearPublish
            .subscribe(onNext: {
                print("second subscription, viewDidAppearPublish")
            })
    }
}
