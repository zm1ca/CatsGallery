//
//  CTGDataLoadingVC.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

class CTGDataLoadingVC: UIViewController {
    
    var isLoadingMoreData = false {
        didSet { updateLoadingViewAppearance() }
    }

    lazy var containerView = UIView(frame: view.bounds)
    
    func updateLoadingViewAppearance() {
        DispatchQueue.main.async {
            if self.isLoadingMoreData {
                self.showLoadingView()
            } else {
                self.dismissLoadingView()
            }
        }
    }
    
    //MARK: Supporting functions
    private func showLoadingView() {
        view.addSubview(containerView)
        
        containerView.backgroundColor = .cornsilk
        containerView.alpha           = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    private func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }

}
