
import UIKit
class CarouselOfImagesView: UICollectionView {

    private var items: [String] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        setupBackground()
        setupRegister()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CarouselOfImagesView")
    }

    lazy var pageIndicator: PaddingLabel = {
        let view = PaddingLabel.init(withInsets: 3, 3, 6, 6)
        view.font = .systemFont(ofSize: 16)
        view.textColor = UIColor.white
        return view
    }()


    func setupBackground() -> Void {

        backgroundColor = UIColor.white
        self.isPagingEnabled = true
        self.delegate = self
        self.dataSource = self
    }

    func setupViews() -> Void {

        self.insertSubview(pageIndicator, aboveSubview: self)
        pageIndicator.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }

    func setupRegister() -> Void {
         self.register(CarouselViewCell.self, forCellWithReuseIdentifier: CarouselViewCell.cellIdentifier())
    }

    func setImages(with images: [String]) -> Void {
        self.items = images
        self.pageIndicator.text = "1/\(items.count)"
        self.pageIndicator.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        self.reloadData()
    }
}

extension CarouselOfImagesView : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return .zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width) + 1
        pageIndicator.text = "\(currentPage)/\(items.count)"
    }
}

extension CarouselOfImagesView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselViewCell.cellIdentifier(), for: indexPath) as? CarouselViewCell
        cell?.configure(with: items[indexPath.row])

        return cell!
    }
}

extension CarouselOfImagesView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
    }
}
