function z = P_xfix_in_p(x,dl,y,P)
X=(x)*dl;
plot(y,P(:,x));
grid on;
title(X);
xlabel('t , ���' );
ylabel('P , ��');
gtext('� ����������');
gtext(num2str(X));
gtext('������');
end