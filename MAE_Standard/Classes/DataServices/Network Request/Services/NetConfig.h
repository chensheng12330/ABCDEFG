//
//  NetConfig.h
//  Template
//
//  Created by Knife on 13-1-2.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#ifndef Template_NetConfig_h
#define Template_NetConfig_h

//#define XDEBUG

//typedef enum {
//    eNewsList,
//    eNewsDetail,
//    
//    eProductCategoryList,
//    eProductList,
//    eProductDetail,
//    
//    eEventCategoryList,
//    eEventList,
//    eEventDetail,
//    
//    eAlumbList,
//    eAlumbDetail,
//    
//    eMore,
//    
//    eForm,
//    eGetForm,
//    eOAuth
//}RequestType;

// http://mae.aim-app.com
// http://dev.mae.aimapp.net

#ifdef XDEBUG

#define APISERVER               @"http://dev.mae.aimapp.net/"
#define APPKEY                  @"VWJTMVJlBDJdZgFjAGQJYwY3VTYGNFMxD2JUZAQxUThTMAJjUzRRYgY0BmRXNgI3"

#else

#define APISERVER               @"http://mae.aim-app.com/"
#define APPKEY                  @"UmUAYwNlXzsBNQE3DmQKNwM2AWsFNFIyVToFMlhhA2pfPAEzXzhXZFJgUjBVNQU1"

#endif

#define Rows                    @"news/api/GetRows"
#define RowDetail               @"news/api/GetRowByID"

#define ProductCategoryList     @"product/api/GetCategoryList"
#define ProductList             @"product/api/GetRows"
#define ProductDetail           @"product/api/GetRowByID"

#define EventCategoryList       @"event/api/GetCategoryList"
#define EventList               @"event/api/GetRows"
#define EventDetail             @"event/api/GetRowByID"

#define Alumb                   @"alumb/api/GetRows"
#define AlumbDetail             @"alumb/api/GetRowByID"

#define Moer                    @"setting/api/GetSetting"

#define XForm                   @"form/api/SaveForm"
#define GForm                   @"form/api/GetRows"

#define OAuth                   @"member/api/LoginFromOAuth"


#endif
