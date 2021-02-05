
import UIKit
protocol MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: MenuTabsView,index: Int)
}
class MenuTabsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   lazy var collView: UICollectionView = {
        let layOut = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layOut)
        cv.showsHorizontalScrollIndicator = false
        layOut.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    var isSizeToFitCellsNeeded: Bool = false {
        didSet{
            self.collView.reloadData()
        }
    }
    var dataArray: [String] = [] {
        didSet{
            self.collView.reloadData()
        }
    }
    var selectedIndex = 0
    var menuDidSelected: ((_ collectionView: UICollectionView, _ indexPath: IndexPath)->())?
    var menuDelegate: MenuBarDelegate?
    var cellId = "BasicCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customIntializer()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customIntializer()
    }
  private func customIntializer () {
        collView.register(BasicCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collView)
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: collView)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: collView)
        backgroundColor = .clear
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BasicCell {
            cell.titleLabel.text = dataArray[indexPath.item]
            if indexPath.row == selectedIndex{
                cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
                cell.titleLabel.textColor = UIColor.black
            }else{
                cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
                cell.titleLabel.textColor = UIColor.gray
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isSizeToFitCellsNeeded {
            let sizeee = CGSize.init(width: 500, height: self.frame.height)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let str = dataArray[indexPath.item]
            let estimatedRect = NSString.init(string: str).boundingRect(with: sizeee, options: options, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)], context: nil)
            return CGSize.init(width: estimatedRect.size.width, height: self.frame.height)
        }
        return CGSize.init(width: (self.frame.width - 10)/CGFloat(dataArray.count), height: self.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = Int(indexPath.item)
        menuDelegate?.menuBarDidSelectItemAt(menu: self, index: index)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func updateCells(forIndex index:Int) {
        for i in 0..<Global.shared.appData.shopList.shops.count{
            if let cell = self.collView.cellForItem(at: IndexPath(row: i, section: 0)) as? BasicCell {
                cell.titleLabel.textColor = UIColor.gray
            }
        }
        if let cell = self.collView.cellForItem(at: IndexPath(row: index, section: 0)) as? BasicCell {
            cell.titleLabel.textColor = UIColor.black
        }
    }
}
