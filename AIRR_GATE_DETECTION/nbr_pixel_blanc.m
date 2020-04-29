function [pix_blanc] = nbr_pixel_blanc(Image,x,y)
%--------------------------------------
 %  function that found the number of pixels blue in a window of 20*20
 %  around the point x y
%---------------------------------------
pix_blanc=0;
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
        if RGB(1)>220
            if RGB(2)>220
                if RGB(3)>220
                    pix_blanc=pix_blanc+1;
                end
            end
        end
     end
end


end
