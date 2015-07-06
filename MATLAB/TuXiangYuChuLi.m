function [ K ] = TuXiangYuChuLi( img_file_name )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% ������ǿ -------------------------------

% image_file_name = 'test.png';
img=double(rgb2gray(imread(img_file_name)));
% figure('name','ԭʼָ��ͼ��');
% imshow(img,[])
[m n]=size(img);

Fe=1;%���Ʋ���
Fd=128;

xmax=max(max(img));
u=(1+(xmax-img)/Fd).^(-Fe);     %�ռ���任��ģ����

%Ҳ���Զ�ε���
for i=1:m                       %ģ������ǿ����
   for j=1:n
      if u(i,j)<0.5
        u(i,j)=2*u(i,j)^2; 
      else
        u(i,j)=1-2*(1-u(i,j))^2;
      end
   end
end

img=xmax-Fd.*(u.^(-1/Fe)-1);    %ģ����任�ؿռ���

% figure('name','�����˲����ͼ��');
img = uint8(img);
% imshow(img);

%---------------------------------------------------------------

%��ֵ��ͼ��-------------------------------------------------------

level=graythresh(img); 
J=im2bw(img,level); 
% figure('name','��ֵ�����ͼ��');
% imshow(J);
%---------------------------------------------------------------

%ͼ��ϸ��--------------------------------------------------------
I=J;
K=bwmorph(~I,'thin','inf');
% figure('name','ͼ��ϸ�����ͼ��');
% imshow(~K);
% saveas(fs,'wan');
%---------------------------------------------------------------


