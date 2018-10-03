//
//  APPermissionManager.swift
//  CalendarTest
//
//  Created by Gints Osis on 02/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit
import EventKit

class APPermissionManager: NSObject {

    enum APPermissionType:Int
    {
        case calendar = 0
    }
    
    private static var sharedPermissionsManager: APPermissionManager = {
        let permissionManager = APPermissionManager.init()
        
        return permissionManager
    }()
    
    // MARK: - Singleton accessor
    
    class func shared() -> APPermissionManager {
        return sharedPermissionsManager
    }
    
   /* func checkCalendarAuthorizationStatus() {
        
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
        case EKAuthorizationStatus.authorized:
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
        }
    }
    */
    
    func askPermissionWithType(permissionType:APPermissionType, presentingVC:UIViewController) -> Void {
        
        let alertController:UIAlertController = UIAlertController.init(title: NSLocalizedString("Access to calendar is disabled", comment: ""), message: "Select ok to enable the fucking thing", preferredStyle: .alert)
        
        let okAction:UIAlertAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            let url:URL = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
        
        alertController.addAction(okAction)
        
        presentingVC.present(alertController, animated: true, completion: nil)
    }
}
