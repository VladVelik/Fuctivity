//
//  PinElements.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 14.12.2022.
//

import UIKit

extension UIView {
    func setButtonConstraints(
        view: UIView,
        element: UIView,
        equalToBottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        bAnchorSize: CGFloat,
        leftAnchorSize: CGFloat = 20,
        rightAnchorSize: CGFloat = 20
    ) {
        element.translatesAutoresizingMaskIntoConstraints = false
        let bottomAnchor = element.bottomAnchor.constraint(equalTo: equalToBottomAnchor, constant: bAnchorSize)
        let leftAnchor = setLeftConstraint(view: view, element: element,
                                           size: leftAnchorSize)
        let rightAnchor = setRightConstraint(view: view, element: element,
                                             size: rightAnchorSize)
        let heightAnchor = setHeightConstraint(view: view, element: element)
            
        NSLayoutConstraint.activate([bottomAnchor, leftAnchor, rightAnchor, heightAnchor])
    }
    
    func setLeftConstraint(view: UIView, element: UIView, size: CGFloat) ->
        NSLayoutConstraint {
        let leftAnchor = element.leftAnchor.constraint(equalTo: view.leftAnchor, constant: size)
        return leftAnchor
    }
    
    func setRightConstraint(view: UIView, element: UIView, size: CGFloat) ->
        NSLayoutConstraint {
        let rightAnchor = element.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -size)
        return rightAnchor
    }
    
    func setHeightConstraint(view: UIView, element: UIView) ->
        NSLayoutConstraint {
        let heightAnchor = NSLayoutConstraint(
            item: element,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 45
        )
        return heightAnchor
    }
}
