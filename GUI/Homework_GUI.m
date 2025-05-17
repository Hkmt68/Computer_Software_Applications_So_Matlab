A = get(handles.slider1, 'Value');
set(handles.Aedit, 'string', num2str(A));
W = get(handles.slider2, 'Value');
set(handles.Wedit, 'string', num2str(W));
t = eval(get(handles.tedit, 'String'));
f = A*sin(W*t);
set(handles.radiobutton1, 'Value', 0);
set(handles.radiobutton2, 'Value', 1);
axes(handles.axes1)
title('f(t) = A sin( \omegat)', 'FontWeight','bold')
xlabel('t')
ylabel('f(t)')
