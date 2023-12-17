//
//  ViewController.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit

private extension String {
    static let alertTitle = "Game over"
    static let alertMessage = "Your score is "
    static let recordsTableTitle = "Go to records table"
    static let actionRestartTitle = "Restart"
    static let buttonStartGameTitle = "Save & star Game"
    static let buttonResetTitle = "Reset"
    static let score = "Score: "
}

private extension Double {
    static let unvisibleSpeed = 0.0
    static let timerInterval = 1.0
    
    static let bgDuration = 7.0
    static let bgDelay = 3.0
    
    static let barrierBlueDelayDivider = 1.5
    static let barrierOrangeDelayDivider = 2.5
    static let barrierGreenDelayDivider = 5.0
}

private extension CGFloat {
    static let carViewTranslationY = 0.7
}

protocol RaceViewControllerDelegate: AnyObject {
    func  senData(data: Double)
}

final class RaceViewController: UIViewController, UIScrollViewDelegate {
    
    private let recordVC = RecordsViewController()
    private let raceView = RaceView()
    private var model: RaceModel
    private var timer: Timer?
    weak var delegate: RaceViewControllerDelegate?
    
    override func loadView() {
        view = raceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPanGesture()
        model.defineSpeed()
        setItemBar()
        self.delegate = recordVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moveBgDown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        raceView.adjustCarViewFrame()
        moveDown()
        startTimer()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        model.isControllerClosed = true
        raceView.bgFirst.layer.removeAllAnimations()
        raceView.bgSecond.layer.removeAllAnimations()
    }

    init(gameLevel: String) {
        self.model = RaceModel(gameLevel: gameLevel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(GeneralConstants.Errors.initError)
    }
    
    
    @objc func backToRootController() {
         navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func moveCar(_ sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            
            if view.center.y >= self.view.frame.height/2 + self.view.frame.height/3 {
                let translation = sender.translation(in: self.view)
                
            view.center = CGPoint(x:view.center.x + translation.x,
                                    y:view.center.y + translation.y)
            
            } else {
                let translation = CGPoint(x: .zero, y: CGFloat.carViewTranslationY)
                view.center = CGPoint(x:view.center.x + translation.x,
                                        y:view.center.y + translation.y)
            }
          }
        defineCrash(barrier: raceView.barrierViewRed)
        defineCrash(barrier: raceView.barrierViewBlue)
        defineCrash(barrier: raceView.barrierViewGreen)
        defineCrash(barrier: raceView.barrierViewOrange)
        sender.setTranslation(.zero, in: self.view)
    }
    
    
    @objc func updateScore() {
        model.updateScore()
        DispatchQueue.main.async {
            self.raceView.scoreLabel.text = "\(String.score)\(self.model.score)"
        }
     }
    
    private func setItemBar() {
        let back = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backToRootController))
       
        navigationItem.rightBarButtonItem = back
        navigationItem.hidesBackButton = true
    }
    
    private func setPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(moveCar(_:)))
        raceView.carView.addGestureRecognizer(pan)
        raceView.carView.isUserInteractionEnabled  = true
    }
    
    private func defineCrash(barrier: UIView) {
        if let layer = barrier.layer.presentation() {
            if  raceView.carView.frame.intersects(CGRect(origin: CGPoint(x: layer.frame.origin.x, y: layer.frame.origin.y), size: CGSize(width: barrier.frame.width, height: barrier.frame.height))) {
                        finishGame()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.timerInterval,
                                     repeats: true) {
            [weak self] timer in
            self?.updateScore()
            self?.defineCrash(barrier: self?.raceView.barrierViewRed ?? UIView())
            self?.defineCrash(barrier: self?.raceView.barrierViewBlue ?? UIView())
            self?.defineCrash(barrier: self?.raceView.barrierViewGreen ?? UIView())
            self?.defineCrash(barrier: self?.raceView.barrierViewOrange ?? UIView())
        }
    }
    
    
    private func finishGame() {
        model.isGameFinished = true
        raceView.carView.isUserInteractionEnabled = false
        timer?.invalidate()
        setAlertFinishGame()
        raceView.barrierViewRed.layer.removeAllAnimations()
        raceView.barrierViewBlue.layer.removeAllAnimations()
        raceView.barrierViewGreen.layer.removeAllAnimations()
        raceView.barrierViewOrange.layer.removeAllAnimations()
        
        delegate?.senData(data: model.score)
    }
    
    private func gameRestart() {
        updateScore()
        raceView.carView.isUserInteractionEnabled = true
        model.isGameFinished = false
        moveLeft()
        startTimer()
    }
    
    
    private func setAlertFinishGame() {
        let alert = UIAlertController(title: String.alertTitle, message: "\(String.alertMessage) \(model.score)", preferredStyle: .alert)
        let actionRestart = UIAlertAction(title: String.actionRestartTitle, style: .default) { _ in
            self.gameRestart()
        }
        
        let actionRecordsTable = UIAlertAction(title: String.recordsTableTitle, style: .default) { _ in
            self.navigationController?.pushViewController(RecordsViewController(), animated: true)
        }
        
        alert.addAction(actionRestart)
        alert.addAction(actionRecordsTable)
        present(alert, animated: true)
    }
    
    private func setAnimation(barriersAndDelay: [UIView: Double], option: UIView.AnimationOptions, firstView: UIView, direction: Diraction, duration: Double ) {
        switch direction {
        case .down: firstView.frame.origin.y +=  view.bounds.height + firstView.frame.size.height
        case .up: firstView.frame.origin.y -= view.bounds.height + firstView.frame.size.height
        case .left: firstView.frame.origin.x -= view.bounds.width + CGFloat(model.randomX)
        case .right: firstView.frame.origin.x += view.bounds.width + CGFloat(model.randomX)
        }
        for (barrier, delay ) in barriersAndDelay {
            UIView.animate(withDuration: duration, delay: delay, options: [option], animations: {
                switch direction {
                case .down: barrier.frame.origin.y += self.view.frame.height + barrier.frame.size.height
                case .up:  barrier.frame.origin.y -=  self.view.frame.height + barrier.frame.size.height
                case .left:  barrier.frame.origin.x  -=  self.view.frame.width + CGFloat(self.model.randomX)
                case .right: barrier.frame.origin.x +=  self.view.frame.width + CGFloat(self.model.randomX)
                }
            })
        }
    }
    
    private func startAnimation(duration: Double, direction: Diraction, handler: @escaping (() -> Void)) {
        UIView.animate(withDuration: duration,
                       delay: .zero,
                       options: []) {
                self.setAnimation(barriersAndDelay: [
                    self.raceView.barrierViewBlue: self.model.speed / Double.barrierBlueDelayDivider,
                    self.raceView.barrierViewGreen: self.model.speed / Double.barrierGreenDelayDivider,
                    self.raceView.barrierViewOrange: self.model.speed / Double.barrierOrangeDelayDivider
                                               ],
                              option: [],
                              firstView: self.raceView.barrierViewRed,
                              direction: direction,
                                  duration: self.model.speed)
        } completion: {  _ in
            guard self.model.isGameFinished || self.model.isControllerClosed else {
                handler()
                return
            }
        }
    }
    
    private func moveDown() {
        startAnimation(duration: model.speed, direction: .down, handler: moveLeft)
    }
    
    private func moveLeft() {
        startAnimation(duration: Double.unvisibleSpeed, direction: .left, handler: moveUp)
    }

    private func moveUp() {
        startAnimation(duration: Double.unvisibleSpeed, direction: .up, handler: moveRight)
    }
    
    private func moveRight() {
        model.getRandomX(view: view)
        startAnimation(duration: Double.unvisibleSpeed, direction: .right, handler: moveDown)
    }
    
    private func moveBgUp() {
        UIView.animate(withDuration: .zero, delay: .zero, options: [.curveLinear]) {
            self.setAnimation(barriersAndDelay: [self.raceView.bgFirst: Double.bgDelay],
                              option: [],
                              firstView:  self.raceView.bgSecond,
                              direction: .up,
                              duration: Double.unvisibleSpeed)
        } completion: { _ in
            self.moveBgDown()
        }
    }
    
    private func moveBgDown() {
        UIView.animate(withDuration: Double.bgDuration, delay: .zero, options: [.curveLinear]) {
            self.setAnimation(barriersAndDelay: [self.raceView.bgFirst: .zero],
                              option: [],
                              firstView:  self.raceView.bgSecond,
                              direction: .down,
                              duration: Double.bgDuration)
        } completion: { _ in
            self.moveBgUp()
        }
    }
}

