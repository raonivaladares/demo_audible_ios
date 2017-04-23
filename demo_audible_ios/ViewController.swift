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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
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
