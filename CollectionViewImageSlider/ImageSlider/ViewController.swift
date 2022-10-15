//
//  ViewController.swift
//  ImageSlider
//
//  Created by Joonhwan Jeon on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private var progressView: UIProgressView = {
       let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .gray
        view.progressTintColor = .white
        return view
    }()
    
    //MARK: - Data
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .systemBlue, .blue, .purple]
    var progress: Progress?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        configureProgressView()
        activateTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let segmentSize = colors.count
        collectionView.scrollToItem(at: IndexPath(item: segmentSize, section: 0),
                                  at: .centeredHorizontally,
                                  animated: false)
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(progressView)
        
        collectionView.register(collectionViewCell.self,
                                forCellWithReuseIdentifier: collectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant:  -20),
            progressView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
    }
    
    private func configureProgressView() {
        progressView.progress = 0.1
        progress = Progress(totalUnitCount: Int64(colors.count))
        progress?.completedUnitCount = 1
        progressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
    
    private func visibleCellIndexPath() -> IndexPath {
        return collectionView.indexPathsForVisibleItems[0]
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
    }
    
    private func activateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3,
                                     target: self,
                                     selector: #selector(timerCallBack),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func timerCallBack() {
        var item = visibleCellIndexPath().item
         if item == colors.count * 3 - 1 {
             collectionView.scrollToItem(at: IndexPath(item: colors.count * 2 - 1, section: 0),
                                       at: .centeredHorizontally,
                                       animated: false)
             item = colors.count * 2 - 1
         }
            
         item += 1
        collectionView.scrollToItem(at: IndexPath(item: item, section: 0),
                                   at: .centeredHorizontally,
                                   animated: true)
         let unitCount: Int = item % colors.count + 1
         progress?.completedUnitCount = Int64(unitCount)
         progressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = colors[indexPath.item % colors.count]
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell.reuseIdentifier, for: indexPath) as? collectionViewCell else { return UICollectionViewCell() }
        
        item.backgroundColor = color
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count * 3
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        invalidateTimer()
        activateTimer()
        
        var item = visibleCellIndexPath().item
        if item == colors.count * 3 - 2 {
            item = colors.count * 2
        } else if item == 2 {
            item = colors.count + 2
        }
        
        collectionView.scrollToItem(at: IndexPath(item: item, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
        
        let unitCount: Int = item % colors.count + 1
        progress?.completedUnitCount = Int64(unitCount)
        progressView.setProgress(Float(progress!.fractionCompleted), animated: false)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}

final class collectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: collectionViewCell.self)
}
