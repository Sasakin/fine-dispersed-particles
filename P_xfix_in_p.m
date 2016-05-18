function z = P_xfix_in_p(x,dl,y,P)
X=(x)*dl;
plot(y,P(:,x));
grid on;
title(X);
xlabel('t , сек' );
ylabel('P , Па');
gtext('в координате');
gtext(num2str(X));
gtext('метров');
end