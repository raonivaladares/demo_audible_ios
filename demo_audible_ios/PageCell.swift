import UIKit

class PageCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpViews()
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.image = UIImage(named: "page1")
    iv.clipsToBounds = true
    return iv
  }()
  
  private func setUpViews() {
    addSubview(imageView)
    imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
