import UIKit
// UICollectionViewDelegate
class ViewController: UIViewController {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.dataSource = self
    cv.delegate = self
    cv.isPagingEnabled = true
    return cv
  }()
  
  let cellID = "cellID"
  let loginCellID = "loginCellID"
  
  let pages: [Page] = {
    let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to people in your life, Every reciepient's first book is on us.", imageName: "page1")
    let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
    let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
    
    return [firstPage, secondPage, thirdPage]
  }()
  
  lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.pageIndicatorTintColor = .lightGray
    pc.currentPageIndicatorTintColor = .orange
    pc.numberOfPages = self.pages.count + 1
    return pc
  }()
  
  let skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.addTarget(self, action: #selector(skip), for: .touchUpInside)
    return button
  }()
  
  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    return button
  }()
  
  var pageControlBottomAnchor: NSLayoutConstraint?
  var skipButtonTopAnchor: NSLayoutConstraint?
  var nextButtonTopAnchor: NSLayoutConstraint?
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    observeKeyboardNotifications()
    
    buildUI()
    registerCell()
  }
  
  // MARK: Private methods
  private func buildUI() {
    view.addSubview(collectionView)
    view.addSubview(skipButton)
    view.addSubview(nextButton)
    view.addSubview(pageControl)
    
    collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    
    skipButtonTopAnchor = skipButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)?.first
    
    nextButtonTopAnchor = nextButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)?.first
    
    pageControlBottomAnchor = pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)?[1]
  }
  
  private func moveControlConstraintsOffScreen() {
    pageControlBottomAnchor?.constant = 40
    skipButtonTopAnchor?.constant = -40
    nextButtonTopAnchor?.constant = -40
  }
  
  private func registerCell() {
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellID)
  }
  
  private func observeKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  // MARK: Selector methods
  @objc private func keyboardShow() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
      self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
  
  @objc private func keyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
  
  @objc private func nextPage() {
    guard pageControl.currentPage < pages.count else {
      return
    }
    
    if pageControl.currentPage == pages.count - 1 {
      moveControlConstraintsOffScreen()
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
    
    let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    pageControl.currentPage += 1
  }
  
  @objc private func skip() {
    pageControl.currentPage = pages.count - 1
    nextPage()
  }
  
  // MARK: Internal methods
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
    pageControl.currentPage = pageNumber
    
    
    if pageNumber == pages.count {
      moveControlConstraintsOffScreen()
    } else {
      skipButtonTopAnchor?.constant = 16
      nextButtonTopAnchor?.constant = 16
      pageControlBottomAnchor?.constant = 0
    }
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    print(UIDevice.current.orientation.isLandscape)
    collectionView.collectionViewLayout.invalidateLayout()
    let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
    DispatchQueue.main.async {
      self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self.collectionView.reloadData()
    }
  }
}

// MARK: Extensions
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == pages.count {
      let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellID, for: indexPath)
      return loginCell
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
    let page = pages[indexPath.item]
    cell.page = page
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
}
