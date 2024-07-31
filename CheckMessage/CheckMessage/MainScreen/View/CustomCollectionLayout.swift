//
//  CustomCollectionLayout.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//

import UIKit

class CustomCollectionLayout: UICollectionViewLayout {
    private var cache = [UICollectionViewLayoutAttributes]()
//    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }

    private var contentHeight: CGFloat {



        guard let collectionView = collectionView else { return 0}

//        let itemsInFirstSection = collectionView.numberOfItems(inSection: 0)
//
//        let height = itemsInFirstSection * 50
//
//        return CGFloat(height)
        return CGFloat(9000)
    }

    override var collectionViewContentSize: CGSize {

        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard let collectionView = collectionView else { return }

        // Reset cache and content height
        cache.removeAll()

//        contentHeight = 0

        let numberOfSections = collectionView.numberOfSections
        print("Number of sections:",numberOfSections)

        let itemWidth = contentWidth
        var yOffset: CGFloat = collectionView.bounds.height > contentHeight ? collectionView.bounds.height - 50 : contentHeight - 50

        // Iterate through sections and items to calculate attributes
        for section in 0..<numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            for item in (0..<numberOfItems).reversed() {
                let indexPath = IndexPath(item: item, section: section)
                let itemHeight: CGFloat = 50 // Example fixed height, customize as needed

                let frame = CGRect(x: 0, y: yOffset, width: itemWidth, height: itemHeight)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)

                yOffset -= itemHeight
            }
        }

        // Set content height
//        contentHeight = max(contentHeight, yOffset)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.indexPath == indexPath }
    }
}

