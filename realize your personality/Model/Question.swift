//
//  Question.swift
//  realize your personality
//
//  Created by Michael Sidoruk on 14/04/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answer: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: ProfessionType
}

enum ProfessionType: Character {
    case cosmonaut = "👩🏻‍🚀", policeman = "👮🏾‍♂️", doctor = "👨🏼‍⚕️", model = "👸🏽"
    
    var definition: String {
        switch self {
        case .cosmonaut:
            return "You don’t believe in the moon landing conspiracy theory. You’re definitely interested in high technologies. You like watching important for mankind rocket launching. Someday you’d like to visit another planet or just try levitation in space. Perhaps, you want to get an electric car. "
        case .policeman:
            return "You’re strict and watchful. You like to help people even if it’s dangerous for you. You approve a law that allow to have a gun in the USA. Someday you’d like to try to shoot by AK-47 at the range. "
        case .doctor:
            return "You’re kind and you like to help people or animals. If someone get injured, you will be the first man who helps them. It’s possible for you to stay at work until late night. You like studying a lot theory, so in your case it’s possible to have been studying for 7 years at a university. "
        case .model:
            return "The first thing that you do when you get your salary it’s going to shops and buying clothes. You like making different outfits, but probably sometimes you have no money for it. Your dream is to visit fashion shows in Paris and New York. If you went to any warm countries, you wound fulled up all your instagram account by your photos."
        }
    }
}
