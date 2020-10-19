//
//  BaseVC.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    final var viewDidAppear = false
    
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

    
}

