//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.09.2023.
//

import UIKit
import UserNotifications

class LocalNotificationsService: NSObject {
    
    enum CategoriesIds {
        static let update = "update"
    }
    
    enum RequestIds {
        static let update = "updateRequest"
    }
    
    enum CategoriesActions: String {
        case check
        case cancel
        static func rV(_ value: Self) -> String {
            value.rawValue
        }
    }
    
    let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        center.removeAllPendingNotificationRequests()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            guard granted, let self else { return }
            self.center.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    self.center.add(self.createRequest())
                }
            }
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func registerUpdatesCategory() {
        center.delegate = self
        
        let actionCheck = UNNotificationAction(
            identifier: CategoriesActions.check.rawValue,
            title: NSString.localizedUserNotificationString(forKey: "LocalNotificationsService.actionCheck.title", arguments: .none)
        )
        let actionCancel = UNNotificationAction(
            identifier: CategoriesActions.cancel.rawValue,
            title: NSString.localizedUserNotificationString(forKey: "LocalNotificationsService.actionCancel.title", arguments: .none),
            options: [.destructive]
        )
        let category = UNNotificationCategory(
            identifier: CategoriesIds.update,
            actions: [actionCheck, actionCancel],
            intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func createRequest() -> UNNotificationRequest {
        
        var dateComponent = DateComponents()
        dateComponent.hour = 19
        dateComponent.minute = 0
        dateComponent.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let content = UNMutableNotificationContent()
        
        content.badge = 1
        content.sound = .default
        content.title = NSString.localizedUserNotificationString(forKey: "LocalNotificationsService.content.title", arguments: .none)
        content.body = NSString.localizedUserNotificationString(forKey: "LocalNotificationsService.content.body",
                                                                arguments: .none)
        content.categoryIdentifier = CategoriesIds.update
        
        let request = UNNotificationRequest(identifier: RequestIds.update, content: content, trigger: trigger)
        return request
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func setCountBadgeToZero() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            setCountBadgeToZero()
            center.removeAllDeliveredNotifications()
        case CategoriesActions.rV(.check):
            setCountBadgeToZero()
        case CategoriesActions.rV(.cancel):
            setCountBadgeToZero()
            center.removeAllPendingNotificationRequests()
        default:
            print("LocalNotificationsService.delegate.didReceive".localized)
        }
        completionHandler()
    }
}
