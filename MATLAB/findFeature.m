function [] = findFeature( img )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
% 当 sn = 3 和 cn = 6 时 表示是分叉点
% 当 sn = 1 和 cn = 2 时 表示是端点
    [m n] = size(img);
    duan_fencha_dot = zeros(m,n,2);
    is_duan_dot = zeros(m,n,2);
    is_fencha_dot = zeros(m,n,2);
    neibor = [0,1;-1,1;-1,0;-1,-1;0,-1;1,-1;1,0;1,1];

    for h = 1:m;
        for w = 1:n;
            if(img(h,w) == 1)
                cn = 0;
                sn = 0;
                for i = 1:8;
                    x = h + neibor(i,1);
                    y = w + neibor(i,2);
                    if(x >=1 && x<=m && y >= 1 && y <=n)
                        if(img(x,y) == 1)
                            sn = sn + 1;
                        end;

                        j = mod(i,8) + 1;
                        x1 = h + neibor(j,1);
                        y1 = w + neibor(j,2);
                        if(x1 >=1 && x1<=m && y1 >= 1 && y1 <=n)
                            if(img(x,y) ~= img(x1,y1))
                                cn = cn +1;
                            end;
                        end;
                    end;
                end;
                duan_fencha_dot(h,w,1) = cn;
                duan_fencha_dot(h,w,2) = sn;
                if(cn == 6 && sn == 3)
                    is_fencha_dot(h,w) = 1;
                end;
                if(cn == 2 && sn == 1)
                    is_duan_dot(h,w) = 1;
                end;
            end;
        end;
%         fprintf('\n');
    end;
    
    %进行分块处理，计算每一块是否都有脊线
    blockn = ceil(n/10);
    blockm = ceil(m/10);
    
    is_border = zeros(blockm,blockn);
    for h = 1:blockm;
        for w = 1:blockn;
            sta = (h-1) *10 + 1;
            e = (w -1) * 10 + 1;
            bo = 0;
            for i = sta:min(sta + 9,m);
                for j = e:min(e + 9,n);
                    if(img(i,j) == 1)
                        bo = 1;
                        break;
                    end;
                end;
                if(bo)
                    break;
                end;
            end;
            if(bo)
                is_border(h,w) = 1;
            end;
        end;
    end;
    
    %筛选出边界块，把特征点进行去除
    for h = 1:blockm;
        for w = 1:blockn;
            if(is_border(h,w) == 1)
                bo = 1;
                for i = 1:8;
                    x = h + neibor(i,1);
                    y = w + neibor(i,2);
                    if(x >=1 && x<=blockm && y >= 1 && y <=blockn && is_border(x,y) == 0)
                        bo = 0;
                        break;
                    end;
                end;
                if(bo == 0)
                    sta = (h-1) *10 + 1;
                    e = (w -1) * 10 + 1;
                    for i = sta:min(sta + 9,m);
                        for j = e:min(e + 9,n);
                            is_duan_dot(i,j) = 0;
                            is_fencha_dot(i,j) = 0;
                            img(i,j) = 0;
                            fprintf('%d %d\n',i,j);
                        end;
                    end;
                end;
            end;
        end;
    end;
    
    %去掉伪点 --------------------------------------------
    
    
    threshold = 8;
    % 1 去掉端点和短线
     for h = 1:m;
        for w = 1:n;
            if(is_duan_dot(i,j) == 1)
                bo = 0;
                for i = 0:threshold;
                    for j = 0:threshold;
                        if(i + j ~= 0 && i + j <=threshold)
                            x = h + i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_duan_dot(x,y))
                                bo = 1;
                                is_duan_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_duan_dot(x,y))
                                bo = 1;
                                is_duan_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_duan_dot(x,y))
                                bo = 1;
                                is_duan_dot(x,y) = 0;
                                break;
                            end;
                            x = h + i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_duan_dot(x,y))
                                bo = 1;
                                is_duan_dot(x,y) = 0;
                                break;
                            end;
                        end;
                    end;
                    if(bo == 1)
                        is_duan_dot(h,w) = 0;
                        break;
                    end;
                end;
            end;
        end;
     end;
     
     %2 去掉毛刺线段
     threshold = 8;
     % 1 去掉端点和短线
     for h = 1:m;
        for w = 1:n;
            if(is_duan_dot(i,j) == 1)
                bo = 0;
                for i = 0:threshold;
                    for j = 0:threshold;
                        if(i + j ~= 0 && i + j <=threshold)
                            x = h + i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h + i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                        end;
                    end;
                    if(bo == 1)
                        is_duan_dot(h,w) = 0;
                        break;
                    end;
                end;
            end;
        end;
     end;
     
     
     %桥和环的删除
     threshold = 8;
     % 1 去掉端点和短线
     for h = 1:m;
        for w = 1:n;
            if(is_fencha_dot(i,j) == 1)
                bo = 0;
                for i = 0:threshold;
                    for j = 0:threshold;
                        if(i + j ~= 0 && i + j <=threshold)
                            x = h + i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w + j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h - i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                            x = h + i;
                            y = w - j;
                            if(x >=1 && x<=m && y >= 1 && y <=n && is_fencha_dot(x,y))
                                bo = 1;
                                is_fencha_dot(x,y) = 0;
                                break;
                            end;
                        end;
                    end;
                    if(bo == 1)
                        is_fencha_dot(h,w) = 0;
                        break;
                    end;
                end;
            end;
        end;
     end;
     
     
     %--------------------------------------------------------------
     
     
     %得到图片特征----------------------------------------------------
     num = zeros(1,8);
     loc = zeros(8,2);
     
     for h = 1:m;
        for w = 1:n;
            is_leagel = zeros(1,8);
            if(img(h,w) == 1)
                for i=1:8;
                    loc(i,1) = h + neibor(i,1);
                    loc(i,2) = w + neibor(i,2);
                end;
                for i=1:8;
                    if(1<=loc(i,1) && loc(i,1)<=m && loc(i,2)>=1 && loc(i,2)<=n && img(loc(i,1),loc(i,2)) == 1)
                        is_leagel(i) = 1;
                    end;
                end;
                
                
                if(is_leagel(1) && is_leagel(5) || is_leagel(2) && is_leagel(4) ||is_leagel(6) && is_leagel(8))
                    num(1) = num(1) + 1;
                end;
                
                if(is_leagel(1) && is_leagel(6) || is_leagel(2) && is_leagel(5) ||is_leagel(7) && is_leagel(8)||is_leagel(3) && is_leagel(4))
                    num(2) = num(2) + 1;
                end;
                
                
                if(is_leagel(2) && is_leagel(6) || is_leagel(3) && is_leagel(5) ||is_leagel(7) && is_leagel(1))
                    num(3) = num(3) + 1;
                end;
                
                if(is_leagel(2) && is_leagel(7) || is_leagel(3) && is_leagel(6) ||is_leagel(1) && is_leagel(8)||is_leagel(5) && is_leagel(4))
                    num(4) = num(4) + 1;
                end;
                
                if(is_leagel(4) && is_leagel(6) || is_leagel(2) && is_leagel(8) ||is_leagel(7) && is_leagel(3))
                    num(5) = num(5) + 1;
                end;
                
                if(is_leagel(4) && is_leagel(7) || is_leagel(3) && is_leagel(8) ||is_leagel(1) && is_leagel(2)||is_leagel(5) && is_leagel(6))
                    num(6) = num(6) + 1;
                end;
                
                if(is_leagel(4) && is_leagel(8) || is_leagel(5) && is_leagel(7) ||is_leagel(1) && is_leagel(3))
                    num(7) = num(7) + 1;
                end;
                
                if(is_leagel(1) && is_leagel(4) || is_leagel(8) && is_leagel(5) ||is_leagel(7) && is_leagel(6)||is_leagel(3) && is_leagel(2))
                    num(8) = num(8) + 1;
                end;
            end;
        end;
     end;
     
     %获得指纹的八个向量所代表的指纹走向图-----------
     disp(num);
%    disp(img);
     total = sum(num);
     fprintf('the m is %d and the n is %d\n',m,n);
     fprintf('the total is %d\n',total);
     num = num/total;
     
     index = 1;
     for i = 2:8;
         if(num(i)>num(index))
             index = i;
         end;
     end;
     
     value = zeros(1,8);
     for i = index:8;
         value(i) = num(i);
     end;
     
     for i = 1:index -1;
         value(i) = num(i);
     end;
     
     %---------获得坐标的均值和方差--------------
     
     cnt = zeros(1,4);
     duan_x = [];
     duan_y = [];
     fencha_x = [];
     fencha_y = [];
     
     for h = 1:m;
        for w = 1:n;
            if(is_duan_dot(h,w))
                cnt(1) = cnt(1) + 1;
                duan_x(cnt(1)) = h;
                cnt(2) = cnt(2) + 1;
                duan_y(cnt(2)) = h;
            end;
            
            if(is_fencha_dot(h,w))
                cnt(3) = cnt(3) +1;
                fencha_x(cnt(3)) = h;
                cnt(4) = cnt(4) +1;
                fencha_y(cnt(4)) = h;
            end;
        end;
     end;
     
     var_duan_x = var(duan_x);
     var_duan_y = var(duan_y);
     var_fencha_x = var(fencha_x);
     var_fencha_y = var(fencha_y);
     
     %输出图像
     figure('name','图像细化后的去除伪点的图像');
     imshow(~img);
     %把数据输出到文件中去
     disp(size(value));
     disp(length(value));
     fid=fopen('fingers_feature.txt','a');
     fprintf(fid,'%f\n',value);
     fprintf(fid,'%f\n',var_duan_x);
     fprintf(fid,'%f\n',var_duan_y);
     fprintf(fid,'%f\n',var_fencha_x);
     fprintf(fid,'%f\n',var_fencha_y);
     fclose(fid);
     
         
     
     
     
     
                
            
            
                
     
     
     
     
     
     
                                
    
                
            
    
                
       
    
    
    
    
    

