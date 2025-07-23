function [invarnames,outvarnames,funfound]=IOvarnames(fun)
% For MATLAB functions that are defined in .m files, return the names of
% the input and output arguments in the function definition.
%
% Joel T Harter
% 2025 07 22
if nargin<1
    fun=stackname(1);
end
funfound=false;
try
mpath=which(fun);
endchar=[char(13),newline];
if ~isempty(mpath)
    ftext=split(fileread(mpath),[endchar,num2cell(endchar)]);
    i=0;
    nlines=length(ftext);
    while i<nlines&&~funfound
        i=i+1;
        defLine=ftext{i}(find(ftext{i}~=' ',1):end);
        while i<nlines
            iPercent=find(defLine=='%',1);
            if ~isempty(iPercent)
                defLine=defLine(1:iPercent-1);
            end
            iEllipsis=strfind(defLine,'...');
            if isempty(iEllipsis)
                break
            else
                i=i+1;
                defLine=[defLine(1:iEllipsis-1),' ',ftext{i}];
            end
        end
        if startsWith(defLine,'function ')
            defLine=defLine(10:end);
            funfound=true;
            break
        end
    end
end
if funfound
    invarnames=extractname(defLine(find(defLine=='(',1):find(defLine==')',1,"last")));
    outvarnames=extractname(defLine(1:find(defLine=='=',1)));
else
    throw("funciont not found")
end
catch
    invarnames="";
    outvarnames="";
end
end

function name=extractname(line)
usechar=[97:122,65:90,48:57,95];
line(~ismember(line,usechar))=newline;
name=split(string(line)',newline);
name(name=="")=[];
end