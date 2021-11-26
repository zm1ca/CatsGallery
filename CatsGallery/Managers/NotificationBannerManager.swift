//
//  NotificationBannerManager.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 24.11.21.
//

import UIKit
import NotificationBannerSwift

class NotificationBannerManager {
    
    static let shared = NotificationBannerManager()
    private init() { }
    
    private let bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 3)
    
    func presentNotificationBanner(title: String, style: BannerStyle) {
        if bannerQueue.numberOfBanners > 2 {
            bannerQueue.dismissAllForced()
        }
        
        UINotificationFeedbackGenerator().notificationOccurred((style == .success) ? .success : .error)
        
        let banner = FloatingNotificationBanner(title: title, style: style)
        banner.applyStyling(titleTextAlign: .center)
        banner.haptic = .none
        banner.show(queuePosition: .front,
                    bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                    cornerRadius: 8,
                    shadowBlurRadius: 15)
    }
}
