function z = v_xfix_in_p(P,dl,y,v)
X=(P)*dl;
plot(y,v(:,P));
grid on;
title(X);
xlabel('t , сек' );
ylabel('v , м/сек');
gtext('в координате');
gtext(num2str(X));
gtext('метров');
end