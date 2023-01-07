clear
close all
clc    
    %Lecture, affichage d’une image
I= imread("CODE.jpg");
figure;  imshow ( I ) ;impixelinfo;
    %Image en niveaux de gris
I_gray=rgb2gray(I);
figure;  imshow ( I_gray ) ;impixelinfo;

    %Histogramme de l'image
figure;imhist(I_gray);
    %Image binaire
I_bin=im2bw(I_gray,125/255);
%seuil= graythresh(I_gray)
%I_bin=im2bw(I_gray,seuil)
figure;  imshow (I_bin) ;

    %Inverser les couleurs
I_bin = imcomplement(I_bin);
figure;  imshow (I_bin) ;

    %Eliminer le petit trous
I_bin1=bwareaopen(I_bin,65);
I_bin2=bwareaopen(I_bin,64);
figure;  
subplot(121), imshow ( I_bin1 ), title('bwareaopen 65')
subplot(122), imshow ( I_bin2 ), title('bwareaopen 64')
I_bin=I_bin1;


%dilatation disk 3
I_dila_1=imdilate(I_bin,strel('disk',1));
I_dila_2=imdilate(I_bin,strel('disk',2)); 
I_dila_3=imdilate(I_bin,strel('disk',3)); 
I_dila_4=imdilate(I_bin,strel('disk',4)); 

figure;
subplot(221), imshow ( I_dila_1 ), title('disk 1')
subplot(222), imshow ( I_dila_2 ), title('disk 2')
subplot(223), imshow ( I_dila_3), title('disk 3')
subplot(224), imshow ( I_dila_4), title('disk 4')


%Localisation des chiffres du code postal
[L,N]=bwlabel(I_dila_3);% on doit verifier que N=5
figure;  imshow ( I_dila_3 ) ;impixelinfo;
RGB = label2rgb(L);
figure;  imshow (RGB ) ;impixelinfo;

figure;
imshow(I);
hold on
%isoler et d’afficher séparément chacun des chiffres présents dans le code postal de l'image
for k = 1:N
    objet= (L==k); 
    [x,y]= find(objet==1);
    Xmin= round(min(x));
    Ymin= round(min(y));
    Xmax= round(max(x));
    Ymax= round(max(y));
    C=imcrop(objet,[Ymin Xmin Ymax-Ymin Xmax-Xmin]);
    % Dessin du rectangle autour du chiffre
    rectangle('Position', [Ymin Xmin Ymax-Ymin Xmax-Xmin], 'EdgeColor', 'r', 'LineWidth', 2);
    %figure;
    %imshow(C);
    
end
hold off
% Extraction des caractéristiques des chiffres





