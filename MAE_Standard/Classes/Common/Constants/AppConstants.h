//
//  AppConstants.h
//  UniversalArchitecture
//
//  Created by zhangli on 12-10-26.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

/**
 *
 * 公共常量类 (需要写清楚注释，以"斜杠+两个星号"开头)
 *
 * @author  zhangli
 * @version  [V1.0.0, 2012-10-26]
 */

#define RCODE_SUCCESS 0
/** 请求数据不存在  */
#define RCODE_DATA_NOT_EXISTS 1
/** 网络异常 */
#define RCODE_NET_ERROR -9
/** 服务器异常 */
#define RCODE_SERVER_ERROR -1

//#define IP_PORT                     @"http://119.145.89.144:9080"
#define IP_PORT                     @"http://59.41.186.142:9081"
//#define IP_PORT                     @"http://10.140.15.115:9080"
//#define IP_PORT                     @"http://10.140.208.122:8080"
#define URL_ROOT                    [IP_PORT stringByAppendingString:@"/mshop/m_shop!"]

#define URL_JSP_ROOT                [IP_PORT stringByAppendingString:@"/mshop/orderHelpUrl.jsp?"]

/** 产品信息更新接口URL */
#define URL_PRODUCT_SYNC            [URL_ROOT stringByAppendingString:@"syncProducts.action"]
/** 库存信息更新接口URL */
#define URL_PRODUCT_CHECKORDER      [URL_ROOT stringByAppendingString:@"checkOrderProduct.action"]
/** 用户的购货权限信息接口URL */
#define URL_USER_RIGHT              [URL_ROOT stringByAppendingString:@"shopStart.action"]

/** 获取店铺地址URL */
#define URL_USER_STORE_ADDR         [URL_ROOT stringByAppendingString:@"getStoreAddress.action"]

/** 获取地址 */
#define URL_USER_GET_HOMEADDR       [URL_ROOT stringByAppendingString:@"getHomeAddressFromPOSV2.action"]

/** 添加家居送货地址（POS） */
#define URL_USER_ADD_ADDR           [URL_ROOT stringByAppendingString:@"saveBackUpDeliveryInfoPOSV2.action"]

/** 删除家居送货接口URL */
#define URL_USER_DEL_HOMEADDR       [URL_ROOT stringByAppendingString:@"deleteHistoryHomeDeliveryPOSV2.action"]

/** 更新一个地址 */
#define URL_USER_UPDATE_HOMEADDR    [URL_ROOT stringByAppendingString:@"updateDeliveryInfoPOSV2.action"]

/**获取全国的省市区和邮编 */
#define URL_USER_GET_DEL_AREA       [URL_ROOT stringByAppendingString:@"queryDeliverWarehouse.action"]

/** 获取店铺地址接口URL */
#define URL_USER_GET_STOREADDR      [URL_ROOT stringByAppendingString:@"getStoreAddress.action"]

/** 添加客户接口URL */
#define URL_USER_ADD_CUSTOMER       [URL_ROOT stringByAppendingString:@"queryCustomer.action"]
/** 保存订单接口URL */
#define URL_CART_SAVE_ORDER         [URL_ROOT stringByAppendingString:@"saveOrder.action"]
/** 获取发票详情接口URL */
#define URL_CART_GET_INVOICE        [URL_ROOT stringByAppendingString:@"getInvoice.action"]
/** 保存促销品信息接口URL */
#define URL_CART_UPDATE_PROMOTION   [URL_ROOT stringByAppendingString:@"usePromotion.action"]
/** 计算运费并返回运费信息接口URL */
#define URL_CART_CAL_DLY_FEE        [URL_ROOT stringByAppendingString:@"calculateDlyFeeInfo.action"]
/** 提交支付接口URL */
#define URL_USER_PAY_ORDER          [URL_ROOT stringByAppendingString:@"payOrder.action"]
/** 订单查询(个人订单)接口URL */
#define URL_USER_CHECK_PER_ORDER    [URL_ROOT stringByAppendingString:@"viewOrders.action"]// add by gwj
/** 订单查询(合并订单)接口URL */
#define URL_USER_CHECK_COM_ORDER    [URL_ROOT stringByAppendingString:@"viewGroupOrders.action"]//add by gwj
/**验证密码 */
#define URL_CHECK_PSW               [URL_ROOT stringByAppendingString:@"checkPsw.action"]//add by zhou
/**再次支付 */
#define URL_REPAY_ORDER             [URL_ROOT stringByAppendingString:@"repayOrder.action"]//add by zhou

//add by gwj
/** 订单详情(个人)*/
#define URL_USER_CHECK_PER_ORDER_DETAIL  [URL_ROOT stringByAppendingString:@"viewOrderDetail.action"]

/** 订单详情(合并)*/
#define URL_USER_CHECK_COM_ORDER_DETAIL  [URL_ROOT stringByAppendingString:@"viewGroupOrderDetail.action"]




//end


/**  二维码整套下订产品查询 */
#define URL_GET_QRCODE_PRODUCTS     [URL_ROOT stringByAppendingString:@"getQrcodeSetProducts.action"]
/**  错误日志上传 */
#define URL_GET_ERROR_REPORT        [URL_ROOT stringByAppendingString:@"errorReport.action"]

/**  重新购买 */
#define URL_GET_REBUY               [URL_ROOT stringByAppendingString:@"findGroupOrderDetailToRepay.action"]


/**  重新购买获取权限列表 */
#define URL_USER_RIGHT_LIST         [URL_ROOT stringByAppendingString:@"shopStartByAdaList.action"]

/**  服务条款URL */
#define URL_SERVICES_TERM           [URL_JSP_ROOT stringByAppendingString:@"dlyType="]

#define URL_INVOICE_TERM          [URL_JSP_ROOT stringByAppendingString:@"op=invoice&ada="]


                                    

/** 请求超时时间 */
#define kRequsetTimeOutSeconds      30.0

/** AES加密密钥 */
#define AES_KEY                     @"amway&mshop123"

/** 数据库 */
#define DB_NAME                     @"mpr_world.db"

/** 购物车动画时间 */
#define kAddToCartAnimationDuration 0.5

//add by gwj
/** 订单模块的页数定义 */
#define OrderRowNum                 10

//订单类型
#define OrderTypeNet                @"NET"
#define OrderTypeBusiness           @"BUSINESS"
#define OrderTypeShopHlep           @"SHOP_SELT_HELP"
#define OrderTypeTel                @"TEL"
#define OrderTypeShopSite           @"SHOP_SITE"
#define OrderTypeFax                @"FAX"
#define OrderHeadTypePerson         @"PERSON"
#define OrderHeadTypeMerge          @"MERGE"
//end


