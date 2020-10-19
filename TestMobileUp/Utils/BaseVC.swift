//
//  BaseVC.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import UIKit
import Network

class BaseVC: UIViewController {
    
    final var viewDidAppear = false
    final let monitor = NWPathMonitor()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppear = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidAppear = false
    }
}

extension BaseVC {
    
    final func showAlert(
        message: String,
        title: String = StringConstants.errorTitle,
        actions: [UIAlertAction] = [],
        completion: (() -> Void)? = nil
    ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(message: message, title: title, actions: actions)
            }
            
            return
        }
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        var resultActions: [UIAlertAction] = []
        
        if actions.isNotEmpty {
            resultActions = actions
        } else {
            let okAction = UIAlertAction(title: StringConstants.alertButton, style: .default)
            
            resultActions = [okAction]
        }
        
        resultActions.forEach(alertController.addAction(_:))
        
        present(alertController, animated: viewDidAppear, completion: completion)
    }
    
    final func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .unsatisfied {
                    self?.showAlert(message: StringConstants.internetIsNotAvailable)
            }
        }
        
        let gueue = DispatchQueue(label: "Network")
        monitor.start(queue: gueue)
    }
    
    final func monitorNetworkServer() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .requiresConnection {
                self?.showAlert(message: StringConstants.serverNotResponding)
            }
        }
        
        let gueue = DispatchQueue(label: "Network")
        monitor.start(queue: gueue)
    }
    
}

