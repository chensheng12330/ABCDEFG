//
//  SHSocketOperation.m
//  SocketTest
//  http://static.doyouhike.net/files/2011/09/30/c/c874081d6b3131befbfe5b6ee4a637ad.jpg
//  Created by sherwin on 13-4-23.
//  "Content-Range" = "bytes 17117-84203/84204"
//

#import "SHSocketOperation.h"
#import "AsyncSocket.h"

#define FILE_SIZE   (@"Content-Length")
#define FILE_RANGES (@"Accept-Ranges")
#define FILE_CRANGE (@"Content-Range")


@interface SHSocketOperation (Private)
- (void)connect;

-(NSString*) buildHTTPRequest;

- (void)sendSocketRequest;

//分析HTTP请求头
-(BOOL) analysisHTTPHeadString:(NSString*)headString ToDiction:(NSMutableDictionary**)diction;
-(CFIndex) setDownloadFileRange;

//URL string
-(NSString *) getHost;
-(NSString *) getScheme;
-(NSString *) getPath;
-(NSString *) getResourceName;
-(NSString *) getIOSAgent;

//file manage
-(void)createBufferFileHandle;
@end

@implementation SHSocketOperation

@synthesize isFinished, fileSize, disconnetCode, sockTag;
@synthesize strPort         = _strPort;
@synthesize delegate        =_delegate;
@synthesize requestMethod   = _requestMethod;
@synthesize fileFolderPath  = _fileFolderPath;

@synthesize requestURL;
@synthesize filePath;

-(void) setFileFolderPath:(NSString *)fileFolderPath
{
    [_fileFolderPath release];
    _fileFolderPath = nil;
    
    
    if (fileFolderPath != NULL) {
        //fileFolderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        BOOL isDir;
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileFolderPath isDirectory:&isDir])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:fileFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _fileFolderPath = [fileFolderPath retain];
    }

    return;
}

#pragma  mark - Data Init
- (id)initWithURL:(NSURL*) url
{
    if(url==NULL) return nil;
    
    self = [super init];
    if (self) {
        requestURL  = [url retain];

        self.fileFolderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.requestMethod = @"GET"; //default is GET, or setting: POST、HEAD
    }
    
    return self;
}


#pragma mark - Main Process
- (void)start
{
    disconnetCode   = DC_Nomarl;
    fileRevSize     = 0;
    cacheFileSize   = 0;
    fileContentLength=0;
    
    filePath = [[self.fileFolderPath stringByAppendingPathComponent:[self getResourceName]] retain];
    
    //1初使化socket连接
	socket = [[AsyncSocket alloc] initWithDelegate:self];
    isFinished = NO;
    
    
    //2启动socket连接
    [self connect];
    
    //3等待代理事件的触发
    //didConnectToHost
    return;
}

- (void)disconnect
{
    [socket disconnect];
}

- (void)stopConnect
{
    disconnetCode = DC_Stop; //手动停止标识
    [self onSocket:socket willDisconnectWithError:nil];
    [socket disconnect];
}

-(void)cancleConnnect
{
    disconnetCode = DC_Cancel;
    
    [self onSocket:socket willDisconnectWithError:nil];
    [socket disconnect];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    
	[socket     release];
    [revData    release];
    [_strPort   release];
    [requestURL release];
    [responseDict release];
    [filePath    release];
	[super dealloc];
}

#pragma mark -Socket Init
//可做为断开后重新连接方法
- (void)connect {
    //2连接到指定的主机
	[socket connectToHost:[self getHost] onPort:80 error:nil];
}


//发送HTTP请求
//1.组装HTTP请求头
//2.写入socket数据包
- (void)sendSocketRequest
{
    ;
    
    NSData *data = [[self buildHTTPRequest] dataUsingEncoding:NSUTF8StringEncoding];
    
	NSLog(@"Sending HTTP Request.");
    
    //2 写入socket数据包
	[socket writeData:data withTimeout:-1 tag:1];
}

// 组建HTTP请求头
- (NSString*) buildHTTPRequest {
    
    //1.组装HTTP请求头
    //1.方法名、host、是否断点下载
    
    NSMutableString *headString = [[NSMutableString alloc] init];
    
    //1 head
    [headString appendFormat:@"%@ %@ %@/1.1\r\n",self.requestMethod, [self getPath], [[self getScheme] uppercaseString]];
    
    //2 host
    [headString appendFormat:@"Host: %@\r\n",[self getHost]];
    
    //3 user Agent
    [headString appendFormat:@"User-Agent: %@ (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.0.0.0)\r\n", [self getIOSAgent]];
	
    //4 accpet
    [headString appendFormat:@"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n"];
    
    //5 language
    //[headString appendFormat:@"Accept-Language: en-us,en;q=0.5\r\n"];
    
    //6 Charset
    //[headString appendFormat:@"Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n"];
    
    [headString appendFormat:@"Accept-Encoding: gzip\r\n"];
    //7
    [headString appendFormat:@"Connection: keep-alive\r\n"];
    //7 Range
    /*
        Range头域
     　　Range头域可以请求实体的一个或者多个子范围。例如，
     　　表示头500个字节：bytes=0-499
     　　表示第二个500字节：bytes=500-999
     　　表示最后500个字节：bytes=-500
     　　表示500字节以后的范围：bytes=500-
     　　第一个和最后一个字节：bytes=0-0,-1
     　　同时指定几个范围：bytes=500-600,601-999
     */
    [headString appendFormat:@"Range: bytes=%@-\r\n",[NSString stringWithFormat:@"%ld", [self setDownloadFileRange]]];
    
    
    //8 end 
    [headString appendFormat:@"\r\n"];

    NSLog(@"%@",headString);
    return [headString autorelease];
}


#pragma mark -
#pragma mark AsyncSocket Methods

//连接将要中断
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    if (err == NULL && (disconnetCode == DC_Nomarl || disconnetCode == DC_Stop) ) {
        //正常结束

        if (err == NULL && (disconnetCode == DC_Nomarl)) {
            //通知数据下载即将完成，可更新UI信息
            SEL sentAction = @selector(onSHSocket:willFinishedWithOperTag:ConnectCode:);
            if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
            {
                [_delegate onSHSocket:self willFinishedWithOperTag:self.sockTag ConnectCode:disconnetCode];
            }
        }
        else //取消资源下载
        {
            SEL sentAction = @selector(onSHSocket:pauseDownloadWithOperTag:RecvDataLength:);
            if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
            {
                [_delegate onSHSocket:self pauseDownloadWithOperTag:self.sockTag RecvDataLength:cacheFileSize+fileRevSize];
            }
        }
    }
    else
    {
        //oh,下载失败
        if (err == NULL) {
            err = [NSError errorWithDomain:@"AsyncSocket" code:0 userInfo:responseDict];
        }
  
        NSLog(@"Disconnecting. Error: %@", [err localizedDescription]);
        
        //不会进入 --onSocketDidDisconnect
        close(revfile);
        
        SEL sentAction = @selector(onSHSocket:didRecvError:RecvDataLength:OperTag:);
        if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
        {
            [_delegate onSHSocket:self didRecvError:err RecvDataLength:revData.length OperTag:self.sockTag];
        }
        
        
    }
    return;
}


//连接已中断
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"Disconnected.");

    //socket结束连接，处理当前线程各种数据
	
    //1.清空未接收完的数据
    
	//2.清空本线程的数据
    close(revfile);
    
    //3.清空socket相关数据
	[socket setDelegate:nil];
	[socket release]; socket = nil;
    
    isFinished = YES;
    
    //通知数据下载完成，可更新UI信息
    
    if (disconnetCode == DC_Nomarl || disconnetCode == DC_Stop || disconnetCode ==DC_Cancel) {
        SEL sentAction = @selector(onSHSocket:didFinishedWithOperTag:);
        if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
        {
            [_delegate onSHSocket:self didFinishedWithOperTag:self.sockTag];
        }
    }
    return;
}


//服务器将要获得连接
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
	NSLog(@"onSocketWillConnect:");
    
    //1.提醒代理，数据开始接收
	return YES;
}

//服务器成功连接，host属性是一个IP地址，而不是一个DNS名称,下一步：socket准备读和写
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	NSLog(@"Connected To %@:%i.", host, port);
    
    //设置socket的读取tag值
    //数据读取间隔为 CRCL*2
    [socket readDataToData:[AsyncSocket CRLF2Data] withTimeout:-1 tag:1];
    
    //发送请求[HTTP,UPD,点对点连接]
    
    //发送请求[开设共用方法]
	[self sendSocketRequest];
    
    //
    SEL sentAction = @selector(onSHSocketDidConnect:OperTag:);
    if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
    {
        [_delegate onSHSocketDidConnect:self OperTag:self.sockTag];
    }
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    if (tag == 1) {  //接收服务器返回请求头
        //接收请求头数据
        NSString *headString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        
        [responseDict release];
        responseDict = [[NSMutableDictionary alloc] init];
        
        if( ![self analysisHTTPHeadString:headString ToDiction:&responseDict]) //判断返回的是否成功
        {
            NSLog(@"%@", responseDict);
            
            //返回失败，中断连接
            disconnetCode = DC_RSP_ER;
            socket.delegate = nil;
            [socket disconnect];
            
            [self onSocket:sock willDisconnectWithError:nil];
            
            //[socket unreadData];
            return;
        }
        
        NSLog(@"%@", responseDict);
        
        SEL sentAction = @selector(onSHSocketDidRecvData:);
        if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
        {
            [_delegate onSHSocketDidRecvData:self];
        }
        
        //设置当前接收文件大小
        NSString *str = [responseDict objectForKey:FILE_SIZE];
        fileContentLength = [str longLongValue];
        
        NSString *strCurRevRange = [responseDict objectForKey:FILE_CRANGE];
        if (strCurRevRange==NULL) {
            fileSize = fileContentLength;
            
            disconnetCode = DC_Nomarl;
            [self onSocket:sock willDisconnectWithError:nil];
            [socket disconnect];
            return;
        }
        
        
        fileSize = fileContentLength + cacheFileSize;
        
        //创建文件副本
        [self createBufferFileHandle];
        
        //继续发送读取数据请求
        [sock readDataWithTimeout:-1 tag:2];
        
        //
    }
    else if(tag ==2) //接收服务器返回的传送数据
    {
        //接收正文数据
        
        //将数据写入文件
        fileRevSize += data.length;
        
        int readSize = [data length];
        write (revfile, (const void *)[data bytes], readSize);
        fsync (revfile);
        
        //fwrite((const void *)[data bytes], readSize, 1, revfile);
        
        //A 接受数据代理
        //NSLog(@"Tag: %d  rev data length:%d  total RevData:%d",self.tag, [data length],[revData length]);
        SEL sentAction = @selector(onSHSocket:didRecvDataOfLength:TotalLength:operTag:);
        if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
        {
            [_delegate onSHSocket:self didRecvDataOfLength:fileRevSize+cacheFileSize TotalLength:fileSize operTag:self.sockTag];
        }
        ///
        
        //B 如果数据接收完毕 ，刚中断该服务器连接
        if (fileContentLength == fileRevSize) {
            disconnetCode = DC_Nomarl;
            
            [self onSocket:sock willDisconnectWithError:nil];
            [socket disconnect];
            return;
        }
        
        //继续发送读取数据请求
        //[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:2];
        //[sock readDataToLength:128 withTimeout:-1 tag:2];
        [sock readDataWithTimeout:-1 tag:2];
        
    }
    else
    {
        NSLog(@"other rev data");
    }
    
    return;
}

#pragma mark - Private Process
-(BOOL) analysisHTTPHeadString:(NSString*)headString ToDiction:(NSMutableDictionary**)diction;
{
    //para process
    if (headString==NULL || [headString isEqualToString:@""]) {
        return NO;
    }
    
    NSMutableDictionary *headDiction = (*diction);
    

    //http head string process
    /*
     HTTP/1.1 200 OK   (/r/n)
     Date: Mon, 22 Apr 2013 07:25:15 GMT
     Server: Microsoft-IIS/6.0
     Content-Length: 89340
     Content-Type: image/jpeg
     Last-Modified: Mon, 25 Feb 2013 07:35:46 GMT
     Accept-Ranges: bytes
     ETag: "8a1b61b92a13ce1:1b42"
     X-Powered-By: ASP.NET
     
     */
    
    NSArray *fields = [headString componentsSeparatedByString:@"\r\n"];
    if (fields.count <1) { return NO;}  //check fields number if >1 return false;
    
    //////1 field
    NSString *httpStatus = [fields objectAtIndex:0];
    NSArray *statusAr  = [httpStatus componentsSeparatedByString:@" "];
    //获取第二节码
    if(statusAr.count<2) return FALSE;
    int StatusCode = [[statusAr objectAtIndex:1] intValue];
    if (StatusCode <200 || StatusCode >=300) {
        [headDiction  setObject:[statusAr objectAtIndex:1] forKey:@"http"];
        return FALSE;
    }
    
    //add to headDiction
    [headDiction setObject:[statusAr objectAtIndex:1] forKey:[statusAr objectAtIndex:0]];
    //////1 field end
    
    ////else code field  add to headDiction
    for (int i=1; i< fields.count; i++) {
        NSString *string = [fields objectAtIndex:i];
        NSArray *arFields = [string componentsSeparatedByString:@": "];
        if (arFields.count <2) {continue;}
        [headDiction setObject:[arFields objectAtIndex:1] forKey:[arFields objectAtIndex:0]];
    }
    
    return YES;
}

-(void)createBufferFileHandle
{
    revfile = open ([self.filePath UTF8String], O_RDWR | O_CREAT | O_APPEND, 0777);
    
    return;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager isExecutableFileAtPath:self.filePath])
    {
        //不存在
        //创建空文件
        [fileManager createFileAtPath:self.filePath contents:[NSData data] attributes:nil];
    }
    else
    {
        //存在
        
    }
    
    //revfile = fopen([self.filePath UTF8String], [@"ab+" UTF8String]);
    
    //revFileHandle = [[NSFileHandle fileHandleForWritingAtPath:self.filePath] retain];
    //[revFileHandle seekToEndOfFile];
}

-(CFIndex) setDownloadFileRange
{
    fileRevSize   = 0;
    cacheFileSize = 0;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isExecutableFileAtPath:self.filePath])
    {
        cacheFileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return cacheFileSize; //初使化文件大小
    }
    
    return 0;
}

#pragma mark - URL String
- (NSString *) getFileName
{
    return [self getResourceName];
}

- (CFIndex) getCacheFileSize
{
    return cacheFileSize;
}

-(NSString *) getHost
{
    if (self.requestURL) {
        return requestURL.host;
    }
    return nil;
}

-(NSString *) getScheme
{
    if (self.requestURL) {
        return requestURL.scheme;
    }
    return nil;
}

-(NSString *) getPath
{
    if (self.requestURL) {
        return requestURL.path;
    }
    return nil;
}

-(NSString *) getResourceName
{
    if (self.requestURL) {
        return [[requestURL pathComponents] lastObject];
    }
    return nil;
}

-(NSString *) getIOSAgent
{
    UIDevice *dev = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@ %@ %@",dev.systemName, dev.systemVersion,dev.model];
}
@end
