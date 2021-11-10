//
//  AppCoordinator.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit

final class AppCoordinator {
    private let session = Session()
    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = DiscoverViewController(viewModel: .init(session: session))
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.navigationBar.tintColor = UIColor.champagne
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
