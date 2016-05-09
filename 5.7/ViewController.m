//
//  ViewController.m
//  5.7
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentiFier=@"cell";
    
    UITableViewCell * cell=[self.tableView dequeueReusableCellWithIdentifier:cellIndentiFier];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentiFier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"star"];
    //得到被选中单元格的索引值
    NSArray * arr=self.tableView.indexPathsForSelectedRows;
    //由于单元格的重用机制，每一次滑动单元格会造成原设置好的单元格内容，重新加载，所以需要通过遍历被选中的单元格，重新设置其内容。
    //遍历数组
    for (NSIndexPath * path in arr) {
        //如果被选中的索引值和单元格的索引值相同，则改变图片
        if ([indexPath isEqual:path]) {
            cell.imageView.image=[UIImage imageNamed:@"star2"];
        }
    }
    return  cell;
}
#pragma -mark 选中单元格方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置被选中单元格的内容
    UITableViewCell*cell= [tableView cellForRowAtIndexPath:indexPath];
    
    cell.imageView.image=[UIImage imageNamed:@"star2"];
}
#pragma -mark 取消选中单元格方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置取消选中单元格的内容
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image=[UIImage imageNamed:@"star"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark 点击按钮
- (IBAction)click:(UIButton *)sender {
    
   
   /*******实现全选方法*******/
    //区分btn点击状态
    sender.selected=!sender.selected;
    
   //创建数组，获得所有单元格的indexpath
    NSMutableArray * arr=[[NSMutableArray alloc]init];
    for (int section =0 ; section<4; section++) {
        for (int row=0; row<10; row++) {
            NSIndexPath * path=[NSIndexPath indexPathForRow:row inSection:section];
            [arr addObject:path];
        }
    }
    
    for (NSIndexPath *path in arr) {
        //获得所有单元格
        UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:path];
        //区分选中和取消选中状态
        if (sender.selected==YES) {
            //设置单元格选中后的展示内容
            cell.imageView.image=[UIImage imageNamed:@"star2"];
            //设置单元格选中状态
            [self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else
        {
            //设置取消选中单元格的展示内容
            cell.imageView.image=[UIImage imageNamed:@"star"];
            //设置单元格取消选中状态
            [self.tableView deselectRowAtIndexPath:path animated:NO];
        }
        
    }
    

}



@end
