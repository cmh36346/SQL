with table_1 as (
    select * from (
        values 
            (1, 'a', 'orange'), 
            (1, 'a', 'red'),
            (1, 'b', 'blue'), 
            (2, NULL, 'turqouise'), 
            (2, NULL, 'green'), 
            (2, NULL, 'yellow')
    ) table_1 (num, letter, color)
) ,table_2 as (
    select * from (
        values
            (1, 'a', 'square'), 
            (1, 'b', 'triange'), 
            (2, 'a', 'rectange'), 
            (2, 'b', 'circle')
    ) table_2 (num, letter, shape)
) select * from table_1
join table_2
    on table_1.num = table_2.num
    and case
        when table_1.letter is null then 1 
        when table_1.letter = table_2.letter then 1 
        else 0
        end = 1 
;
/* join table_2 on table_1.num = table_2.num and table_1.letter = table_2.letter
#
num     letter      color       num     letter      shape
1       a           orange      1       a           square
1       a           red         1       a           square
1       b           blue        1       b           triange
*/ 

/* join table_2 on table_1.num = table_2.num and case
    when table_1.letter is null then 1 
    when table_1.letter = table_2.letter then 1 
    else 0
end = 1 

num     letter      color       num     letter      shape
2               turqouise       2       b           circle
2               turqouise       2       a           rectange
2               green           2       b           circle	
2               green           2       a           rectange
2               yellow          2       b           circle
2               yellow          2       a           rectange
1       a       orange          1       a           square
1       a       red             1       a           square
1       b       blue            1       b           triange
*/ 
