//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class 나중에생기는데이터<T> {
    private let task: (@escaping(T) -> Void) -> Void
    
    init(task: @escaping (@escaping(T) ->Void) -> Void){
        self.task = task
    }
         func 나중에오면(_ f: @escaping (T) -> Void){
        task(f)
    }
}
class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }

    // MARK: SYNC
    private func downloadJson(_ url: String) -> Observable<String?> {
        return Observable.create() { emmiter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {print("error 1")}
                if data != nil{
                    let json = String(data: data!, encoding: .utf8)
                    emmiter.onNext(json)
                    emmiter.onCompleted()
                }
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
                
            
        }

    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        downloadJson(MEMBER_LIST_URL)
            .subscribe{  event in
                switch event {
                case .next(let json):
                    DispatchQueue.main.async {
                        self.editView.text = json
                        self.setVisibleWithAnimation(self.activityIndicator, false)
                    }
                case .completed:
                    print("completed:")
                case .error(let error):
                    print("error : \(error)")
                }
                
            }
         


    }
}
