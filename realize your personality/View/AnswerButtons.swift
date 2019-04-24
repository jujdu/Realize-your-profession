//
//  AnswerButtons.swift
//  realize your personality
//
//  Created by Michael Sidoruk on 21/04/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class AnswerButtons: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = frame.size.height / 2
    }
}
