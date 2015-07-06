function [ K ] = TuXiangYuChuLi( img_file_name )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% 空域增强 -------------------------------

% image_file_name = 'test.png';
img=double(rgb2gray(imread(img_file_name)));
% figure('name','原始指纹图像');
% imshow(img,[])
[m n]=size(img);

Fe=1;%控制参数
Fd=128;

xmax=max(max(img));
u=(1+(xmax-img)/Fd).^(-Fe);     %空间域变换到模糊域

%也可以多次迭代
for i=1:m                       %模糊域增强算子
   for j=1:n
      if u(i,j)<0.5
        u(i,j)=2*u(i,j)^2; 
      else
        u(i,j)=1-2*(1-u(i,j))^2;
      end
   end
end

img=xmax-Fd.*(u.^(-1/Fe)-1);    %模糊域变换回空间域

% figure('name','空域滤波后的图像');
img = uint8(img);
% imshow(img);

%---------------------------------------------------------------

%二值化图像-------------------------------------------------------

level=graythresh(img); 
J=im2bw(img,level); 
% figure('name','二值化后的图像');
% imshow(J);
%---------------------------------------------------------------

%图像细化--------------------------------------------------------
I=J;
K=bwmorph(~I,'thin','inf');
% figure('name','图像细化后的图像');
% imshow(~K);
% saveas(fs,'wan');
%---------------------------------------------------------------


