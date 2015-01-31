#import <Cocoa/Cocoa.h>

int main(int argc, char * argv[]) {
    
    NSString *name = @"Finding Largest set of anagram.......";
    NSLog(@"%d",name);
   
    NSString *filePath = [NSString stringWithUTF8String:argv[1]];
    NSLog(@"---%@--- file ", filePath);
    NSString* fileContents =
    [NSString stringWithContentsOfFile:filePath
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    NSUInteger length = [allLinedStrings count];
    NSMutableArray *arranged = [[NSMutableArray alloc] initWithArray:allLinedStrings];
    
    
    for(int i=0;i<length;i++ )
    {
        
        NSString *str = [allLinedStrings objectAtIndex:(i)];
        NSMutableArray *charArray = [NSMutableArray arrayWithCapacity:str.length];
        for (int i=0; i<str.length; ++i) {
            NSString *charStr = [str substringWithRange:NSMakeRange(i, 1)];
            [charArray addObject:charStr];
        }
        [charArray sortUsingComparator:^(NSString *a, NSString *b){
            return [a compare:b];
        }];
        
        NSMutableString * result = [[NSMutableString alloc] init];
        for (NSObject * obj in charArray)
        {
            [result appendString:[obj description]];
        }
        
        
        [arranged replaceObjectAtIndex:i withObject:result];
        
        
    }
    
    NSMutableDictionary *dir = [[NSMutableDictionary alloc] initWithCapacity:length];
    
    for (int i=0; i<length; i++) {
        
        
        NSString *temp = [arranged objectAtIndex:i];
        if(i==0)
        {
            [dir setObject:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil] forKey:temp];
            
            
        }
        else
        {
            if([dir objectForKey:temp])
            {
                
                
                NSMutableArray *ref = dir[temp];
                
                [ref addObject:[NSNumber numberWithInt:i]];
                
                [dir setObject:ref forKey:temp];
                
                NSMutableArray *test = [dir objectForKey:temp];
                
                
                
                
                
            }
            else
            {
                [dir setObject:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil] forKey:temp];
            }
            
        }
        
        
    }
    
    
    NSLog(@"---total number of anagrams are ---- %d", [dir count]);
    
    
    NSMutableString *largest_anagram = [[NSMutableString alloc] initWithString:@"jeet"];
    int max=0;
    
    NSArray *keys=[dir allKeys];
    
    for(int i=1; i<[keys count]; i++)
    {
        
        if([[dir objectForKey:[keys objectAtIndex:i]] count]>max)
        {
            max=[[dir objectForKey:[keys objectAtIndex:i]] count];
            
            largest_anagram = [keys objectAtIndex:i];
        }
        
    }
    
    
    NSArray *final = [dir objectForKey:largest_anagram];
    
    NSLog(@"-----length of largest anagram is %d------",[final count]);
    
    
    
    for (int i=0; i<[final count]; i++) {
        
        NSLog(@"%@---", [allLinedStrings objectAtIndex:[[final objectAtIndex:i] integerValue]]);
    }
    
    
    
    return 0;
}
