function output = colorFilter(d, k)
if nargin == 1
    k = 0;
end
[h w c] = size(d);
output = zeros(h,w,3);
d2 = d * 3;
d2 = d2 - k;
for i=1:h
    for j=1:w
        if d2(i,j) < 1
            output(i,j,1) = d2(i,j);
            output(i,j,2) = 0;
            output(i,j,3) = 0;
        elseif d2(i,j) < 2
            output(i,j,1) = 1;
            output(i,j,2) = d2(i,j) - 1;
            output(i,j,3) = 0;
        else
            output(i,j,1) = 1;
            output(i,j,2) = 1;
            output(i,j,3) = d2(i,j) - 1;
        end
    end
end
end