 function y = v_tfix_in_p(P,dt,x,v)
X=(P)*dt;
hold on;
plot(x,v(P,:));
grid on;
title(X);
xlabel('x , �' );
ylabel('v , �/���');
gtext('� ������ �������');
gtext(num2str(X));
gtext('������');
end