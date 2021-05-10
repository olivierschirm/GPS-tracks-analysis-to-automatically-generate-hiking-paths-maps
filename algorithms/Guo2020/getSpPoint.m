function point = getSpPoint(p1,p2,p3)
d12 = sum((p2-p1).^2,2);
u = sum((p3-p1).*(p2-p1),2)/d12;
point = p1 + (p2-p1)*u;

