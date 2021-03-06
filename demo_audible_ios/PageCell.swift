import UIKit

class PageCell: UICollectionViewCell {
  var page: Page? {
    didSet{
      guard let page = page else {
        return
      }
      
      let imageName = UIDevice.current.orientation.isLandscape ? page.imageName + "_landscape" : page.imageName
      imageView.image = UIImage(named: imageName)
      
      let color = UIColor(white: 0.2, alpha: 1)
      let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
      attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: color]))
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      let length = attributedText.string.characters.count
      attributedText.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSRange(location: 0, length: length))
      textView.attributedText = attributedText
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.image = UIImage(named: "page1")
    iv.clipsToBounds = true
    return iv
  }()
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.text = "Sample TEXT FOR NOW"
    tv.isEditable = false
    tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    return tv
  }()
  
  let lineSeparatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    return view
  }()
  
  // MARK: Inits
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private methods
  private func setUpViews() {
    addSubview(imageView)
    addSubview(textView)
    addSubview(lineSeparatorView)
    
    imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    lineSeparatorView.anchorToTop(top: nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    textView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
    textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
  }
}
