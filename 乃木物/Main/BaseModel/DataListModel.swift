//
//  DataListModel.swift
//  乃木物
//
//  Created by ncm on 2017/5/6.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class DataListModel: BaseModel {
    var delivery:TimeInterval = 0 //文章投送时间
    var timeStr = ""
    var type = DataType.blog        //文章类型
    var title = ""                //文章标题
    var subtitle = ""             //文章副标题
    var provider = ""             //提供者 （ 字幕组名字 ）
    var summary = ""              //文章摘要
    var detail = ""               //文章详情
    var view = ""                 //文章预览（移动端页面）
    var withpic = [DataListImagesModel](){
        didSet{
            if withpic.count > 2{
                self.isThreeImage = true
            }else{
                self.isThreeImage = false
            }
        }
    }//文章附图
    
    var isThreeImage = false
    
    //详情
    var article = ""  //全文详情html字段
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        delivery <- map["delivery"]
        type <- map["type"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        provider <- map["provider"]
        summary <- map["summary"]
        detail <- map["detail"]
        view <- map["view"]
        withpic <- map["withpic"]
        timeStr = delivery.toDateString
        article <- map["article"]
    }
    
    func getWeb()->String{
        var html = "<!DOCTYPE html><html><head>"
        html+="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
        html+="<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"/>"
        html+="</head>"
        html+=String.baseStyle
        html+="<body>"
        html+=self.title.html_strong
        html+=self.type.hasValue
        html+="<br>"
        html+=self.provider.html_float(type: .left)
        html+=self.timeStr.html_float(type: .right)
        html+=HTML.clearFloat
        html+="<br>"
        html+="<hr />"
        html+=self.article
        html+="</body>"
        html+="</html>"
        return html
    }
}

class DataListImagesModel:BaseModel {
    
    var image = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        image <- map["image"]
    }
    
}
