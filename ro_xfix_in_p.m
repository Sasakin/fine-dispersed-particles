function z = ro_xfix_in_p(P,dl,y,ro)
X=(P)*dl;
plot(y,ro(:,P));
grid on;
title(X);
xlabel('t , ���' );
ylabel('ro , kg/m^3');
gtext('� ����������');
gtext(num2str(X));
gtext('������');
end

