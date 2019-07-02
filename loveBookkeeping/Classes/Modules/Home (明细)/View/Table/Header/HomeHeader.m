/**
 * 头视图
 * @author 郑业强 2018-12-16 创建文件
 */

#import "HomeHeader.h"
#import "HOME_EVENT.h"

#define _kColor_Text_Black RGBA(255,255,255,1)

#pragma mark - 声明
@interface HomeHeader()
@property (weak, nonatomic) IBOutlet UILabel *yearLab;
@property (weak, nonatomic) IBOutlet UILabel *incomeDescLab;
@property (weak, nonatomic) IBOutlet UILabel *payDescLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *monthDescLab;
@property (weak, nonatomic) IBOutlet UILabel *incomeLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setConstraintL;
@property (weak, nonatomic) IBOutlet UIView *monthView;
@property (weak, nonatomic) IBOutlet UIImageView *laughView;

@end


#pragma mark - 实现
@implementation HomeHeader


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self.yearLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightBold]];
    [self.yearLab setTextColor:_kColor_Text_Black];
    [self.monthLab setFont:[UIFont systemFontOfSize:AdjustFont(16) weight:UIFontWeightBold]];
    [self.monthLab setTextColor:_kColor_Text_Black];
    [self.payDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightBold]];
    [self.payDescLab setTextColor:_kColor_Text_Black];
    [self.incomeDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightBold]];
    [self.incomeDescLab setTextColor:_kColor_Text_Black];
    [self.monthDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightBold]];
    [self.monthDescLab setTextColor:_kColor_Text_Black];
    [self.line setBackgroundColor:_kColor_Text_Black];
    [self.lineConstraintL setConstant:SCREEN_WIDTH / 4];
    [self.incomeLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightBold]];
    [self.incomeLab setTextColor:_kColor_Text_Black];
    [self.payLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.payLab setTextColor:_kColor_Text_Black];
    [self.payLab setAttributedText:[NSAttributedString createMath:@"00.00" integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    [self.incomeLab setAttributedText:[NSAttributedString createMath:@"00.00" integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    [self.monthView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self routerEventWithName:HOME_MONTH_CLICK data:nil];
    }];
}


#pragma mark - set
- (void)setDate:(NSDate *)date {
    _date = date;
    _yearLab.text = [@(date.year) description];
    _monthLab.text = [@(date.month) description];
}
- (void)setModels:(NSMutableArray<BKMonthModel *> *)models {
    _models = models;
    UIFont *integer = [UIFont systemFontOfSize:AdjustFont(14)];
    UIFont *decimal = [UIFont systemFontOfSize:AdjustFont(12)];
    NSString *pay = [NSString stringWithFormat:@"%.2f", [[models valueForKeyPath:@"@sum.pay.floatValue"] floatValue]];
    NSString *income = [NSString stringWithFormat:@"%.2f", [[models valueForKeyPath:@"@sum.income.floatValue"] floatValue]];
    [_payLab setAttributedText:[NSAttributedString createMath:pay integer:integer decimal:decimal]];
    [_incomeLab setAttributedText:[NSAttributedString createMath:income integer:integer decimal:decimal]];
}

//- (void)setModel:(BKModel *)model {
//    _model = model;
//    NSString *pay = [NSString stringWithFormat:@"%.2f", model.pay];
//    NSString *income = [NSString stringWithFormat:@"%.2f", model.income];
//    [_payLab setAttributedText:[NSAttributedString createMath:pay integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
//    [_incomeLab setAttributedText:[NSAttributedString createMath:income integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
//}

- (void)setLaugh {
    _laughView.image = [UIImage imageNamed:@"laugh"];
}

- (void)setNotLaugh {
    _laughView.image = [UIImage imageNamed:@"notlaugh"];
}


@end
