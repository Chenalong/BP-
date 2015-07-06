% fid=fopen('output.txt','a');
% value = [3,4,5,6];
% clc;
% fprintf(fid,'%f\n',value);
% fclose(fid);
% 
% fid=fopen('output.txt');
% 
% vall = fscanf(fid,'%f',[1,inf]);
% fclose(fid);
% disp(vall);
% 
% disp(1);
% x = 0:.1:1;
% y = [x; exp(x)];
% 
% fid = fopen('exp.txt', 'w');
% fprintf(fid, '%6.2f %12.8f\n', y);
% fclose(fid);

% fid = fopen('exp.txt');
% A = fscanf(fid, '%g %g', [2 inf]);
% fclose(fid);
% disp(A);
% [m,n] = size(A);
% disp(m);
% % disp(n);
% 
% a = [2,3;4,5;6,7];
% disp(a(2,1));
% A = zeros(3,4,2);
% 
% disp(size(A));
a = zeros(1,8);
if(a(3) ~= 0)
    fprintf('it is true');
end;

