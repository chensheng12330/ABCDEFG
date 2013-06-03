//
//  SHSocketOperation.h
//  SocketTest
//
//  Created by sherwin on 13-4-23.
//
//


#import <Foundation/Foundation.h>

typedef enum
{
    DC_None,
    DC_Nomarl,  //正常停止
    DC_Cancel,  //取消
    DC_Stop,    //手动停止
    DC_RSP_ER,  //请求失败
    DC_Other   
}Disconnect_Code;
//中断连接代码

@class AsyncSocket;
@class SHSocketOperation;

@protocol SHSocketDelegate <NSObject>

@optional
//服务端已连接
- (void)onSHSocketDidConnect:(SHSocketOperation *)sock OperTag:(long) tag;

- (void)onSHSocketDidRecvData:(SHSocketOperation *)sock;

//数据接收进度
- (void)onSHSocket:(SHSocketOperation *)socketOper didRecvDataOfLength:(long)recvLength TotalLength:(long)totalLength operTag:(long)tag;

//数据将要接收完成
- (void)onSHSocket:(SHSocketOperation *)socketOper willFinishedWithOperTag:(long) tag ConnectCode:(Disconnect_Code) code;

//暂停下载
-(void) onSHSocket:(SHSocketOperation *)socketOper pauseDownloadWithOperTag:(long)tag RecvDataLength:(long) recvLenght;

//数据接收完成
- (void)onSHSocket:(SHSocketOperation *)socketOper didFinishedWithOperTag:(long) tag;

//数据接收失败
- (void)onSHSocket:(SHSocketOperation *)socketOper didRecvError:(NSError*) error RecvDataLength:(long) recvLenght OperTag:(long) tag;
@end

@interface SHSocketOperation : NSObject
{
    AsyncSocket *socket;  //socket流对象
    
    NSURL *requestURL;    //请求URL
    NSMutableData *revData;
    
    BOOL    isFinished;
    CFIndex fileSize;      //文件总大小
    CFIndex fileRevSize;   //文件已接收大小
    CFIndex cacheFileSize; //已缓冲文件大小
    CFIndex fileContentLength; //当前将要接收数据大小
    
    NSString *filePath;    //文件储存路径
    
    Disconnect_Code disconnetCode; //内部状态码
    
    NSMutableDictionary *responseDict; //服务器返回消息
    
    int revfile; //buffer文件句柄
}

//初使化
- (id)initWithURL:(NSURL*) url;

//启动数据下载
- (void)start; 

//中断连接
- (void)disconnect;

//手动停止连接
- (void)stopConnect;

//取消下载
- (void)cancleConnnect;

- (NSString *) getFileName;  //获取存储文件名
- (CFIndex) getCacheFileSize;

@property (nonatomic, assign)   int sockTag;
@property (nonatomic, retain)   NSString *strPort;
@property (nonatomic, retain)   NSString *requestMethod;  //请求方法
@property (nonatomic, retain)   NSString *fileFolderPath; //文件储存文件夹路径
@property (nonatomic, assign)   id<SHSocketDelegate>  delegate;

@property (nonatomic, readonly) BOOL    isFinished;  //外部监测
@property (nonatomic, readonly) NSString *filePath;  
@property (nonatomic, readonly) CFIndex fileSize;    //长度 [byte]
@property (nonatomic, readonly) NSURL *requestURL;   //请求URL
@property (nonatomic, readonly) Disconnect_Code disconnetCode;

@end
