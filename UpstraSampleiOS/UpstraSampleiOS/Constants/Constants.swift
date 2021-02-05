//
//  Constants.swift
//  UpstraSampleiOS
//
//  Created by Fahad on 09/11/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation
import UIKit
struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_8P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XS_MAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
}


struct AppMessages {
    static let noFunctionalityMessage = "Sorry, this function is not available in Upstra SDK"
    static let invalidJsonData = "There is invalid data in source file"

}

struct AppFonts {
    static let SFUITextSemiBold =  "SFUIText-Semibold"
    static let SFUITextRegular = "SFUIText-Regular"
    static let SFProDisplayHeavy = "SFProDisplay-Heavy"
    static let SFProDisplayRegular = "SFProDisplay-Regular"
    static let SFProDisplayBold = "SFProDisplay-Bold"
    static let SFProDisplaySemi = "SFProDisplay-Semibold"
    static let SFProDisplayBlack = "SFProDisplay-Black"
    static let SFUITextMedium = "SFUIText-Medium"
    static let SFUITextLight = "SFUIText-Light"
}
let GENERAL_COMMENT_WIDTH = ScreenSize.SCREEN_WIDTH - 80

let MORE_SECTIONS = ["My Purchases","My Bookmarks"]

let PEOPLE_DISSCUSSION = " people are discussing this"
let VIEWERS = " people are viewing"


let HOME_TITLE = "SneakerHead"
let SHOP_TITLE = "Shop"
