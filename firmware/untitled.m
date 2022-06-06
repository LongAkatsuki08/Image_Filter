ht = uicontrol('style','edit','Position',[10,60,40,40]);
hs = uicontrol('style','slider','Position',[10,10,400,20]);
% fun = @(~,e)set(ht,'String',num2str(get(e.AffectedObject,'Value')));
% addlistener(hs, 'Value', 'PostSet',fun);