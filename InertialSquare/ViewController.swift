//
//  ViewController.swift
//  InertialSquare
//
//  Created by Yernar Masujima on 16.05.2023.
//

import UIKit

final class ViewController: UIViewController {
	
	private lazy var squareView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBlue
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		
		view.addGestureRecognizer(tapGesture)
		
		view.addSubview(squareView)
		NSLayoutConstraint.activate([
			squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			squareView.widthAnchor.constraint(equalToConstant: 100),
			squareView.heightAnchor.constraint(equalToConstant: 100)
		])
	}
	
	private func animateView(to position: CGPoint) {
		let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5) {
			self.squareView.center = position
			self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.5...0.5))
		}
		
		animator.addCompletion { [weak self] _ in
			UIView.animate(withDuration: 0.3) {
				self?.squareView.transform = .identity
			}
		}
		
		animator.startAnimation()
	}

	@objc
	private func handleTap(_ gesture: UITapGestureRecognizer) {
		let location = gesture.location(in: view)
		animateView(to: location)
	}
}
