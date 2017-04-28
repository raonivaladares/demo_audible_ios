import UIKit

class MainNavigationController: UINavigationController {
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    if isLoggedIn() {
      let homeViewController = HomeViewController()
      viewControllers = [homeViewController]
    } else {
      perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
    }
  }
  
  // MARK: Selector methods
  @objc private func showLoginController() {
    let loginController = LoginViewController()
    present(loginController, animated: true, completion: nil)
  }
  
  // MARK: Private methods
  private func isLoggedIn() -> Bool {
    return true
  }
}

class HomeViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    let imageView = UIImageView(image: UIImage(named: "home"))
    view.addSubview(imageView)
    _ = imageView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
}
