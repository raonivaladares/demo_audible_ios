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
  
  let pages: [Page] = {
    let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to people in your life, Every reciepient's first book is on us.", imageName: "page1")
    let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
    let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
    
    return [firstPage, secondPage, thirdPage]
  }()
  
  let pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.pageIndicatorTintColor = .lightGray
    pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
    pc.numberOfPages = 3
    return pc
  }()
  
  let skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    return button
  }()
  
  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    view.addSubview(skipButton)
    view.addSubview(nextButton)
    view.addSubview(pageControl)
    
    collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
    
    _ = skipButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
    
    _ = nextButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
    
    _ = pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
