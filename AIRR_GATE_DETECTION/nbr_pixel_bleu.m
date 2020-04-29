function [pix_bleu] = nbr_pixel_bleu(Image,x,y)
%--------------------------------------
 %  function that found the number of pixels blue in a window of 20*20
 %  around the point x y
%---------------------------------------
pix_bleu=0;
if x>10
    if x<length(Image(1,:,1))-10
        l=x-10;
        r=x+10;
    else
        r=length(Image(1,:,1));
        l=length(Image(1,:,1))-20;
    end
else
    l=1;
    r=21;
end

if y>10
    if y<length(Image(:,1,1))-10
        u=y-10;
        d=y+10;
    else
        u=length(Image(:,1,1))-20;
        d=length(Image(:,1,1));
    end
else
    u=1;
    d=21;
end

for i=l:r
    for j=u:d
        RGB=Image(j,i,:);
        if RGB(1)>50 & RGB(1)<130%R>35 & R<95
            if RGB(2)>50 & RGB(2)<130%G>80 & G<140
                if RGB(3)>80 & RGB(3)<200%B>150 & B<240
                    pix_bleu=pix_bleu+1;
                end
            end
        end
     end
end


end