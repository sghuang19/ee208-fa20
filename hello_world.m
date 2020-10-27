close all
clear
% reply = input('Hello World? Y/N [Y]', 's');

% if isempty(reply)
%     reply = 'Y';

%     reply2 = input('What is your name?', 's')
%     fprintf('The area is %8.5f\n', pi)

% end

x = rand(10, 10);
y = x(1:2:end, 1:2:end);

% plot(y)
plot(y)
figure
plot(3, 3, '*')

print()
