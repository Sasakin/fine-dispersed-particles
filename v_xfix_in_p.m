function z = v_xfix_in_p(P,dl,y,v)
X=(P)*dl;
plot(y,v(:,P));
grid on;
title(X);
xlabel('t , ���' );
ylabel('v , �/���');
gtext('� ����������');
gtext(num2str(X));
gtext('������');
end