function [ minZplug, maxZplug, avgZplug ] = matchingZplugWattInterval(ZplugActive, timeline)
%
%    function [ minZplug, maxZplug, avgZplug ] = matchingSensorInterval(sensActive, timeline)
%
%

lenghtTimeline = size(timeline);
lenghtTable=size(ZplugActive);

minZplug = zeros(1,lenghtTimeline(2));
maxZplug = zeros(1,lenghtTimeline(2));
avgZplug = zeros(1,lenghtTimeline(2));

% to set up the first interval
startTimeline=addtodate(datenum(timeline(1,1)), -3, 'minute');
endTimeline=datenum(timeline(1,1));
nextJ=1;
for i=1:lenghtTimeline(2)
    endInnerLoop=0;
    j=nextJ; % to avoid to check the previous intervals
    batch=zeros(90,1);
    k=1;
    while(j<=lenghtTable(2) && endInnerLoop==0)
        instant=datenum(ZplugActive(2,j));
        if(instant < startTimeline) % to avoid to check the previous intervals
            nextJ = j+1;
%             disp('instant'); ZplugActive(2,j)
%             if (i>1) 
%                 disp('startTimeline'); timeline(1,i-1) 
%             end
%            disp("instant < startTimeline");
%             disp('--------------');
             
        elseif (endTimeline < instant) % to avoid to check the next intervals
            endInnerLoop=1;
%             disp('endTimeline'); timeline(1,i)
%             disp('instant'); ZplugActive(2,j)
%             disp("endTimeline < instant");
%             disp('--------------');
        else
%             i
%             j
%             k
%             size(batch(k,1))
%             size(cell2mat(ZplugActive(1,j)))
%             size(k)
%            disp('--------------------------------');
            batch(k)=str2double(cell2mat(ZplugActive(1,j)));
            k=k+1;
        end
        j=j+1;
    end
    if(k>1)
        minZplug(i)=min(batch(1:k-1));
        maxZplug(i)=max(batch(1:k-1));
        avgZplug(i)=mean(batch(1:k-1));
    else
        minZplug(i)=1;
        maxZplug(i)=1;
        avgZplug(i)=1;
    end
    startTimeline=datenum(timeline(1,i));
    if(i~=lenghtTimeline(2)) % to avoid Out Of Bound Error
        %i
        %lenghtTimeline(2)
        %disp('-------');
        endTimeline=datenum(timeline(1,i+1));
    end
end
minZplug=num2cell(minZplug);
maxZplug=num2cell(maxZplug);
avgZplug=num2cell(avgZplug);
end