//
//  LanguageRes.h
//  AmwayMCommerce
//
//  Created by 张 黎 on 12-01-09.
//
//

//场景-----------------------提示语
/**************************产品******************************/

//产品目录，列表提示语：
//热销产品列表：无热卖品，进入热卖品列表界面	提示“暂无热卖品!”
#define kNoHotProduct                           @"暂无热销品!"
//各类别产品详情界面无产品描述	提示“暂无产品描述!”
#define kNoProductDesc                          @"暂无产品描述！"
//加入购物车（加入的数量为0、100、特殊字符）时	提示“产品数量超过1~99！”
#define kIlleNumber                             @"产品数量超过1~99！"
#define kQrResultIlleNumber                     @"产品数量超过0~99！"

//公用模块提示语：
//"进入产品列表/搜索/快速下单页面时，遵循更新库存或者产品信息机制，
//"	"页面提示‘产品信息更新中’，可以做其他操作。
#define kProductUpdating                        @"产品信息更新中"


//任意一种(列表/搜索/快速下单页面)更新失败，	提示‘产品信息更新失败!’
#define kUpdateFailMessage                      @"产品信息更新失败！"
//网络问题导致检查失败，	提示‘网络连接失败！’
#define kNetworkError                           @"网络连接失败！"
//后台程序出错或server无响应，	提示‘系统忙，请稍后再试’；      //这条已服务器返回的为准

//检查的返回值为‘无权限’时，	提示‘该用户未开通网上购货’，
#define kNoOrderCompetence                      @"该用户未开通网上购货"

//手机没有开启GPRS/3G网络/wifi 时，	提示‘当前手机无网络信号，请检查网络设置！’  //去掉了

//我的收藏提示语：
//触摸“加入收藏”按钮	提示“该产品已加入收藏！”
#define kHasAddFavorite                         @"该产品已加入收藏！"
//触摸“取消收藏”按钮	提示：该产品已取消收藏！
#define kCancelFavorite                         @"该产品已取消收藏！"

#define kAddFavoriteFail                        @"加入收藏失败！"
#define kCancelFavoriteFail                     @"取消收藏失败！"
//无收藏产品	提示：暂无收藏产品！
//‘我的收藏’查看下架/失效产品详情	在我的收藏列表置底展示。页面提示：‘产品已下架’
#define kUndercarriage                          @"产品已下架"

//搜索提示语：
//进入搜索界面搜索不到产品时	搜索结果为‘暂无产品！’
#define kSearchNoResult                         @"暂无产品！"
    
#define kHasAddedToCart                         @"当前选中的商品已加入购物车，是否现在进行结算？"
#define kSettle                                 @"去结算"

#define kConfirmClearData                       @"确认清空产品数据！"

/**************************更换购货人******************************/

//新增购货人为当前登录用户帐号时	提示‘若想本人购货，请选择“自用”.’
#define kPleaseSelectSelf                       @"若想本人购货，请选择“自用”."
//更换购货人’新增搜索栏中输入不存在的客户信息	提示‘安利号码不存在或已过期’（本地与网络提示一致）
#define kSearchAdaNoResult                      @"安利号码不存在或已过期！"
//更换购货人在线搜索，搜索失败	提示：在线搜索安利卡号“XXXX”失败，是否重试？（在提示语下方添加“重试”按钮）
#define kSearchAdaFail                          @"在线搜索安利卡号“%@”失败，是否重试？"
//联网检查当前购货人权限网络异常或超时（30秒）	提示应简短：‘网络链接失败'。
#define kChangePurchaserTip                     @"更换成功，所选购产品将放入“%@-%@”购物车中！"


/**************************快速下单******************************/
#define kNoStock                                @"暂时缺货！"

/**************************二维码购货提示语******************************/
//二维码如能识别，但无匹配产品则	提示：产品二维码无效，是否重新扫描？（带二个按钮，返回首页、重新扫描）
#define kNoQueryProduct                         @"产品二维码无效，是否重新扫描？"
//摄像头异常（如已损坏），则在二维码页面	提示：摄像头异常，请检查摄像头!
#define kCameraError                            @"摄像头异常，请检查摄像头!"
#define kBack_To_Home_Page                      @"返回首页"
#define kReScan                                 @"重新扫描"
#define kContinueScan                           @"继续扫描"

/**************************购物车提示语******************************/
//购物车列表为空，	则提示：暂无购物车！
#define kNoShoppingCart                         @"暂无购物车！"
//下订单时检测到送货地址为空，	提示‘送货地址不能为空！’
#define kAddrCanNotBlank                        @"送货地址不能为空！"
//修改购物车中产品数量输入框，	允许输入1-99数字
//点击确认付款时，连接网络异常，	则弹出提示框：获取数据失败!是否重试？（提供“重试”“返回”按钮）
#define kPayNetworkError                        @"获取数据失败!是否重试？"
//修改产品时，连接网络异常，	则在当前页面弹出提示：更新数据失败！是否重试？（提供“重试”“返回”按钮）
#define kModifyQuantityNetworkError             @"更新数据失败！是否重试？"
//获取发头票信息，连接网络超时，	则在页面提示：获取发票信息失败！
#define kInvoiceError                           @"获取发票信息失败！"

#define kNoDeliveryAddress                      @"无家居送货地址！"
#define kAddressNotBlack                        @"送货地址不能为空！"
#define kPleaseEnterAddress                     @"请输入家居送货地址！"

//获取送货地址失败
#define kGetAddrError                           @"地址获取失败，点击此处重新获取地址！"
#define kGetAddrFailed                           @"获取送货地址失败！"

//送货地址，电话号码为空与手机号码为空时提示	电话号码和手机号码必须填写至少一个
#define kPhoneMustHaveOne                       @"固话号码和手机号码必须填写至少一个！"
//送货地址，电话号码错误或者手机号码错误时提示	电话号码填写不正确 / 手机号码填写不正确
#define kPhoneError                             @"电话号码填写不正确！"
#define kMobileError                            @"手机号码填写不正确！"
//详细地址为空时，提示	详细地址填写不正确
#define kDelAddrNotBlank                        @"详细地址填写不正确！"
//邮政编码为空或者填写错误时，提示	邮政编码填写不正确
#define kPostCodeError                          @"邮政编码填写不正确！"

//当前送货地址已有5个，点击新增地址，	则在当前页面弹出提示：送货地址不能超过5个！
#define kOverAddrError                          @"送货地址不能超过5个！"


#define kNotStandard                            @"您的家居送货登记地址未进行标准化输入，请调整地址后再进行下单！"
#define kModify                                 @"修改"
#define kSureDeleteAddress                      @"确定删除该地址？"
#define kDelete                                 @"删除"

//连接网络中断或连接网络超过30秒，	则页保持在当前页面，并提示：网络异常，请稍候再试！
//修改送货地址时，有订单处理于未送货（含付款中）的订单，	则提示：您仍有尚未送货（含付款中）的订单，请在公司送货后再进行地址的修改操作。

#define kDeliveFreight                          @"本次家居送货订单未达到2,000.00元免运费订货额，收货时需向配送公司支付50.00元运费，请确认。"
#define kDeliveGoodsAddr                        @"您仍有尚未送货（含付款中）的订单，请在公司送货后再进行地址的修改操作。"

#define kCouponOverError                        @"电子劵金额/净营业额不能大于或等于购货金额/净营业额！"
#define kShut                                   @"关闭"
#define kCancel_Modify                          @"取消修改"
#define kCoupon_Modify                          @"修改金额"
#define kCoupon_Over_Available                  @"超过可用金额%@"
#define kCoupon_Rule_For_10                     @"使用电子劵必须为10的倍数"
#define kCoupon_Rule_For_100                    @"使用电子劵必须为100的倍数"

#define KCancel_Add                             @"取消加入"
#define KModify_Quantity                        @"修改数量"
#define KModify_Add                             @"修改添加"

#define kOver_Available_Quantity                @"超出可购买数量，请修改！"

#define kHasPromotion                           @"您有可购买的促销品，是否按默认数量购买并继续付款？"
#define kViewPromotion                          @"查看促销品"
#define kPleaseSelectCart                       @"请选择购物车！"

#define kInvoiceTitleError                      @"发票抬头不能为空！"


#define kInvoiceTitleErrorCh                    @"发票抬头只能为中文！"

#define kTaxIdentification                      @"纳税识别号最少为15个字符！"
/**************************我的收藏******************************/

#define kNoFavoriteProduct                      @"暂无收藏产品！"

/**************************订单管理******************************/

//add by gwj
//订单查询 返回结果未空时
#define KOrderNoRecordReturn                    @"暂无订单信息"
//end

#define kSure_Add_All_Product                   @"确定把该订单中所有产品加入%@(%@)-%@购物车中?"

#define kAdd_To_Cart                            @"加入购物车"


/**************************支付******************************/
#define KPaySuccess                             @"支付成功！"
#define KPayFail                                @"支付失败！"
#define KPayRetry                               @"是否重试支付！"
#define kViewPayResult                          @"查看订单"
#define kContinueShopping                       @"继续购物"
#define kVerifieError                           @"签名错误"
#define kRead_Home_Term                         @"请阅读并同意《关于安利（中国）家居送货的服务条款》的内容。"
#define kRead_Store_Term                        @"请阅读并同意《关于安利（中国）店铺自提的服务条款》的内容。"
#define kNo_Install_Alipay_Client               @"您还没有安装支付宝的客户端，请先装。"


/**************************错误日志******************************/
#define kErr_Report_Title                       @"提示"
#define kErr_Report_Message                     @"有错误日志，是否反馈？"
#define kErr_Report_Btn_Sure                    @"好"


/**************************其他******************************/
#define kSystemBusy                             @"系统繁忙,请稍后再试"
#define kCancel                                 @"取消"
#define kSure                                   @"确定"
#define kRetryCancel                            @"否"
#define kRetrySure                              @"是"
#define kBack                                   @"返回"


#define kLastDayTip                             @"为免影响业绩归属，月末一天订单请在当天23：59分前提交并成功付款，敬请留意。"

