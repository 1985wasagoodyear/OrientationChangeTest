//
//  OrientationTestViewController.swift
//  OrientationChangeTest
//
//  Created by K Y on 12/23/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit

private let CELL_REUSE_ID = "reuseID"
private let MARGIN_SPACING: CGFloat = 2.0
private let CELLS_PER_ROW: CGFloat = 3.0

final class OrientationTestViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            // reminder: set estimated height to `none` in InterfaceBuilder
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    /// property to help evaluate changes of cell sizes for `collectionView`
    private(set) var cellSize: CGSize? {
        willSet {
            if let oldSize = cellSize,
                let newValue = newValue,
                newValue != oldSize {
                print("Size did change for cell from \(oldSize) to \(newValue)")
            }
        }
    }

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        let center =
            NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(orientationDidChange),
                           name: UIDevice.orientationDidChangeNotification,
                           object: nil)
    }
    
    deinit {
       UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    // MARK: - Orientation-Change Methods
    
    // called when orientation is changed
    // setup using NSNotificationCenter
    @objc func orientationDidChange() {
        print("Orientation did change from NSNotificationCenter!")
        
        // are these actually needed?
        // when is one better for use?
        // collectionView.collectionViewLayout.invalidateLayout()
        // collectionView.reloadData()
        changeTitle(for: UIDevice.current.orientation)
    }
    
    // called when orientation is changed
    // overridden method, called by UIViewController
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        print("Orientation did change from UIViewController!")
    }
    
    /// changes the title for the current orientation
    /// helps to visualize what is the current orientation
    func changeTitle(for orientation: UIDeviceOrientation) {
        let text: String
        switch orientation {
            case .portrait: // Device oriented vertically, home button on the bottom
                text = "portrait"
            case .portraitUpsideDown: // Device oriented vertically, home button on the top
                text = "portraitUpsideDown"
            case .landscapeLeft: // Device oriented horizontally, home button on the right
                text = "landscapeLeft"
            case .landscapeRight: // Device oriented horizontally, home button on the left
                text = "landscapeRight"
            case .faceUp: // Device oriented flat, face up
                text = "faceUp"
            case .faceDown: // Device oriented flat, face down
                text = "faceDown"
            default:
                text = "Unknown"
        }
        title = text
    }

}

extension OrientationTestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 90
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_REUSE_ID,
                                                   for: indexPath) as! CircleCollectionViewCell
        c.label.text = String(indexPath.row + 1)
        return c
    }
    
}

extension OrientationTestViewController: UICollectionViewDelegate { }

extension OrientationTestViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth: CGFloat = collectionView.frame.size.width
        // double the margin to account for edgeInsets
        let marginUsed = (MARGIN_SPACING * 2.0) * (CELLS_PER_ROW - 1.0)
        let widthPerItem = (availableWidth - marginUsed) / CELLS_PER_ROW
        // keep track of the cellSize change, for observations
        cellSize = CGSize(width: widthPerItem, height: widthPerItem)
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: MARGIN_SPACING,
                     left: MARGIN_SPACING,
                     bottom: MARGIN_SPACING,
                     right: MARGIN_SPACING)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MARGIN_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MARGIN_SPACING
    }
}
