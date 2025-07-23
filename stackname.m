function name=stackname(i)
% Get the names of files in the stack
%
% Joel T Harter
% 2025/07/23
stack=dbstack;
if nargin<1
    i=2:length(stack);
else
    i=i+2;
end
name=strings(size(i));
I=0<i&i<=length(stack);
if any(I)
    name(I)=stack(i(I)).name;
end