% % Originally written by Sharon George to Analyze masson trichome histology images
% saved as TIFFs.
% 
% Modifications made by Rose Yin

function varargout = MassonTrichromeAnalysis(varargin)
% MASSONTRICHROMEANALYSIS MATLAB code for MassonTrichromeAnalysis.fig
%      MASSONTRICHROMEANALYSIS, by itself, creates a new MASSONTRICHROMEANALYSIS or raises the existing
%      singleton*.
%
%      H = MASSONTRICHROMEANALYSIS returns the handle to a new MASSONTRICHROMEANALYSIS or the handle to
%      the existing singleton*.
%
%      MASSONTRICHROMEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASSONTRICHROMEANALYSIS.M with the given input arguments.
%
%      MASSONTRICHROMEANALYSIS('Property','Value',...) creates a new MASSONTRICHROMEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MassonTrichromeAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MassonTrichromeAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MassonTrichromeAnalysis

% Last Modified by GUIDE v2.5 09-May-2017 15:24:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MassonTrichromeAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @MassonTrichromeAnalysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MassonTrichromeAnalysis is made visible.
function MassonTrichromeAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MassonTrichromeAnalysis (see VARARGIN)

% Choose default command line output for MassonTrichromeAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global FileName
global White
global Pink
global Blue
global BinImage1
global BinImageFinal
global Image



% UIWAIT makes MassonTrichromeAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MassonTrichromeAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Close all figures windows from previous analyses except Masson Trichrome Analysis GUI
gui = findall(0,'type','figure','name','MassonTrichromeAnalysis');
allfigures = findall(0, 'type', 'figure');
other_figures = setdiff(allfigures, gui);
delete(other_figures);

global FileName
global White
global Pink
global Blue
global BinImage1
global BinImageFinal
global Image

pathname='*.tif';
[FileName,PathName]=uigetfile(pathname,'Select the Image');
set(handles.FileName,'String',FileName);
FullFilename=horzcat(PathName,FileName);
Image = im2double(imread(FullFilename));

RGB=[0.8784 0.8392 0.8275;0.4118 0.0471 0.2745; 0.2941 0.3137 0.8196];

%Make sure to click the colors in the image in this order
White=RGB(1,:); 
Pink=RGB(2,:);
Blue=RGB(3,:);

% --- Executes on button press in ResetRGB.
function ResetRGB_Callback(hObject, eventdata, handles)
% hObject    handle to ResetRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
global FileName
global White
global Pink
global WhiteBinImageFinal
global Blue
global BinImage1
global BinImageFinal
global Image

figure('Name','Choose WHITE, then PINK, then BLUE for RGB reference. Hit ENTER when done.')
RGB=impixel(Image); %Returns the value of the RBG data for the selected pixel
White=RGB(1,:);
Pink=RGB(2,:);
Blue=RGB(3,:);

close 


% --- Executes on button press in SelectArea.
function SelectArea_Callback(hObject, eventdata, handles)
% hObject    handle to SelectArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName
global White
global Pink
global Blue
global BinImage1
global BinImageFinal
global Image

%%Draws mask on image to select area of interest
figure(1)
imshow(Image);
DrawMain = impoly();
BinImage1 = createMask(DrawMain);
BinImageFinal=BinImage1;
close 


% --- Executes on button press in DeselectArea.
function DeselectArea_Callback(hObject, eventdata, handles)
% hObject    handle to DeselectArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName
global White
global Pink
global Blue
global BinImage1
global BinImageFinal
global Image

figure(1);
DrawBV = imfreehand();
BinImage2 = createMask(DrawBV);

BinImageFinal=BinImageFinal-BinImage2;
close 


% --- Executes on button press in Hold.
function Hold_Callback(hObject, eventdata, handles)
% hObject    handle to Hold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure(1)
hold;
WhitePixel=0;
BluePixel=0;
PinkPixel=0;
WhiteFinal=0;
PinkFinal=0;
BlueFinal=0;


function WhitePercent_LV_Callback(hObject, eventdata, handles)
% hObject    handle to WhitePercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WhitePercent_LV as text
%        str2double(get(hObject,'String')) returns contents of WhitePercent_LV as a double


% --- Executes during object creation, after setting all properties.
function WhitePercent_LV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WhitePercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PinkPercent_LV_Callback(hObject, eventdata, handles)
% hObject    handle to PinkPercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PinkPercent_LV as text
%        str2double(get(hObject,'String')) returns contents of PinkPercent_LV as a double


% --- Executes during object creation, after setting all properties.
function PinkPercent_LV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PinkPercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BluePercent_LV_Callback(hObject, eventdata, handles)
% hObject    handle to BluePercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BluePercent_LV as text
%        str2double(get(hObject,'String')) returns contents of BluePercent_LV as a double


% --- Executes during object creation, after setting all properties.
function BluePercent_LV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BluePercent_LV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WhitePercent_RV_Callback(hObject, eventdata, handles)
% hObject    handle to WhitePercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WhitePercent_RV as text
%        str2double(get(hObject,'String')) returns contents of WhitePercent_RV as a double


% --- Executes during object creation, after setting all properties.
function WhitePercent_RV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WhitePercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PinkPercent_RV_Callback(hObject, eventdata, handles)
% hObject    handle to PinkPercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PinkPercent_RV as text
%        str2double(get(hObject,'String')) returns contents of PinkPercent_RV as a double


% --- Executes during object creation, after setting all properties.
function PinkPercent_RV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PinkPercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BluePercent_RV_Callback(hObject, eventdata, handles)
% hObject    handle to BluePercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BluePercent_RV as text
%        str2double(get(hObject,'String')) returns contents of BluePercent_RV as a double


% --- Executes during object creation, after setting all properties.
function BluePercent_RV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BluePercent_RV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Analyze.
function Analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName
global Pink
global White
global Blue
global BinImage1
global BinImageFinal
global Image


for i=1:1:3
    MaskedImg(:,:,i) = BinImageFinal .* Image(:,:,i);
end

% % Pink_Low_R=Pink(1)-0.25;
% % Pink_High_R=Pink(1)+0.25;
% % Pink_Low_G=Pink(2)-0.3;
% % Pink_High_G=Pink(2)+0.3;
% % Pink_Low_B=Pink(3)-0.3;
% % Pink_High_B=Pink(3)+0.3;

% % PinkLow=[Pink_Low_R Pink_Low_G Pink_Low_B];
% % PinkHigh=[Pink_High_R Pink_High_G Pink_High_B];

WhiteLow=White-0.25; WhiteHigh=White+0.25;
PinkLow=Pink-0.20; PinkHigh=Pink+0.20;
BlueLow=Blue-0.20; BlueHigh=Blue+0.20;

WhiteFinal=0; PinkFinal=0; BlueFinal=0;

for i=1:1:size(MaskedImg,1)
    for j=1:1:size(MaskedImg,2)
        WhitePixel=0;
        PinkPixel=0;
        BluePixel=0;
        for k=1:1:size(MaskedImg,3)
            Pixel=MaskedImg(i,j,k);
            if WhiteLow(k)<Pixel && Pixel<WhiteHigh(k)
                WhitePixel=WhitePixel+1;
            end
            if PinkLow(k)<Pixel && Pixel<PinkHigh(k)
                PinkPixel=PinkPixel+1;
            end
        end
            if WhitePixel==3
                    WhiteImg(i,j)=1;
                    WhiteFinal=WhiteFinal+1;
            elseif PinkPixel==3
                        PinkImg(i,j)=1;
                        PinkFinal=PinkFinal+1;
            elseif WhitePixel~=3 && PinkPixel~=3 && Pixel~=0
                        BlueImg(i,j)=1;
                        BlueFinal=BlueFinal+1;
            end
    end
end

% % Show figures all in one window
figure('Name','Analysis Results')
subplot(2,2,1)
    imshow(MaskedImg);
    title('Selected area (masked)')
subplot(2,2,2)
    imshow(WhiteImg);
    title('White')
subplot(2,2,3)
    imshow(PinkImg);
    title('Pink')
subplot(2,2,4)
    imshow(BlueImg);
    title('Blue')

% % Show figures separately
% figure(2); 
% imshow(MaskedImg);
% figure(3);
% imshow(WhiteImg);
% title('White')
% figure(4);
% imshow(PinkImg);
% title('Pink')
% figure(5)
% imshow(BlueImg);
% title('Blue')

Total=0;
for i=1:1:size(MaskedImg,1)
    for j=1:1:size(MaskedImg,2)
        Pixel=MaskedImg(i,j,1);
        if Pixel~=0
            Total=Total+1;
        end
    end
end

WhitePercent=(WhiteFinal/Total)*100;
PinkPercent=(PinkFinal/Total)*100;
BluePercent=(BlueFinal/Total)*100;

set(handles.WhitePercent_LV,'String',num2str(WhitePercent));
set(handles.PinkPercent_LV,'String',num2str(PinkPercent));
set(handles.BluePercent_LV,'String',num2str(BluePercent));

% STILL TESTING (RY 6/29/19)
% %Automatically save percentage values into Excel spreadsheet
% 
% %Get full name of file
% pathname='*.tif';
% [FileName,PathName]=uigetfile(pathname,'Select the Image');
% set(handles.FileName,'String',FileName);
% FullFilename=horzcat(PathName,FileName);
% 
% %Prompt box asks user if they would like to save OAP trace data
% prompt1 = {'Would you like to save these values?'};
%     dlg_title = 'Export percentages';
%     num_lines1 = 1;
%     answer = {inputdlg(prompt1,dlg_title,num_lines1,FullFilename)}; %prefilled answer
% if isempty(answer)      % cancel save if user clicks "cancel"
%      return
% else
% 
% %Close all figures windows from previous analyses except Masson Trichrome Analysis GUI
% gui = findall(0,'type','figure','name','MassonTrichromeAnalysis');
% allfigures = findall(0, 'type', 'figure');
% other_figures = setdiff(allfigures, gui);
% delete(other_figures);
% 
% %Make new folder called "Data Analysis" to excel values
% if exist(strcat(PathName,'/Data_analysis'),'dir')==0 
%     mkdir(PathName, 'Data_analysis'); %Makes directory for analysis folder
% end
