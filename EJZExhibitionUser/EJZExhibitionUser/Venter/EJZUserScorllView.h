//
//  EJZUserScorllView.h
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/5/7.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface EJZUserScorllView : UIView
@class EJZUserScorllView;

@protocol EJZScrollViewDelegate <NSObject>
@optional
/** 点击cell回调 */
- (void)EJZScrollView:(EJZUserScorllView *)scrollView didSelectItemAtIndex:(NSInteger)index;
/** 图片滚动回调 */
- (void)EJZScrollView:(EJZUserScorllView *)scrollView didScrollToIndex:(NSInteger)index;

@end

@interface EJZUserScorllView : UIView <UIScrollViewDelegate>
@property (nonatomic, weak) id<EJZScrollViewDelegate> delegate;
/** block方式监听 */
@property (nonatomic, copy) void (^itemDidScrollToBlock)(NSInteger currentIndex);

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIImageView *leftIV;
@property (nonatomic,strong) UIImageView *centerIV;
@property (nonatomic,strong) UIImageView *rightIV;
@property (nonatomic,assign) NSUInteger currentImageIndex;
/** 页码指示器 */
@property (nonatomic,strong) UIPageControl *pageControl;
/**  当前小圆点颜色 */
@property(nonatomic,retain)UIColor *curPageControlColor;
/**  其余小圆点颜色  */
@property(nonatomic,retain)UIColor *otherPageControlColor;
/** 占位图*/
@property (nonatomic,strong) UIImage  *placeHolderImage;
/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;
/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;
/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

@property (nonatomic,strong) NSArray *sourceDataArr;//数据源
/**
 图片间有间距  又要有翻页效果～～
 @param margnPadding 图片间 间距
 @param imgWidth 图片宽
 */
+(instancetype)initWithFrame:(CGRect)frame withMargnPadding:(CGFloat)margnPadding withImgWidth:(CGFloat)imgWidth;
+(instancetype)initWithFrame:(CGRect)frame withMargnPadding:(CGFloat)margnPadding withImgWidth:(CGFloat)imgWidth dataArray:(NSArray *)dataArray;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
@end
