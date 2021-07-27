function varargout = ProjectGui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectGui_OutputFcn, ...
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


% --- Executes just before ProjectGui is made visible.
function ProjectGui_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for ProjectGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectGui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in load_btn.
function load_btn_Callback(hObject, eventdata, handles)
global orignalImage
[filepath]=uigetfile({'*.*';'*.jpg';'*.png';'*.bmp'},'Choose Orignal Image to Enhance');
orignalImagePath=[filepath];
orignalImage=imread(orignalImagePath)
axes(handles.orignal_image)
imshow(orignalImage)


% --- Executes on selection change in enhance_options.
function enhance_options_Callback(hObject, eventdata, handles)
global orignalImage
global eh_options
contents=cellstr(get(hObject,'String'));
eh_options=contents(get(hObject,'Value'));
if (strcmp(eh_options,'Image Negative'))
    set(handles.logFactor,'visible','Off');
    set(handles.logFactor_lbl,'visible','Off');
    set(handles.gamma,'visible','Off');
    set(handles.gamma_lbl,'visible','Off');
    set(handles.boxFilter,'visible','Off');
    set(handles.gaussianFilter,'visible','Off');
    set(handles.medianFilter,'visible','Off');
    set(handles.boxSize,'visible','Off');
    set(handles.gaussSize,'visible','Off');
elseif (strcmp(eh_options,'Log Transformation'))
    set(handles.logFactor,'visible','On');
    set(handles.logFactor_lbl,'visible','On');
    set(handles.gamma,'visible','Off');
    set(handles.gamma_lbl,'visible','Off');
    set(handles.boxFilter,'visible','Off');
    set(handles.gaussianFilter,'visible','Off');
    set(handles.medianFilter,'visible','Off');
    set(handles.boxSize,'visible','Off');
    set(handles.gaussSize,'visible','Off');
elseif (strcmp(eh_options,'Gamma Transformation'))
    set(handles.gamma,'visible','On');
    set(handles.gamma_lbl,'visible','On');
    set(handles.logFactor,'visible','Off');
    set(handles.logFactor_lbl,'visible','Off');
    set(handles.boxFilter,'visible','Off');
    set(handles.gaussianFilter,'visible','Off');
    set(handles.medianFilter,'visible','Off');
    set(handles.boxSize,'visible','Off');
    set(handles.gaussSize,'visible','Off');
elseif (strcmp(eh_options,'Smoothing'))
    set(handles.logFactor,'visible','Off');
    set(handles.logFactor_lbl,'visible','Off');
    set(handles.gamma,'visible','Off');
    set(handles.gamma_lbl,'visible','Off');
    set(handles.boxFilter,'visible','On');
    set(handles.gaussianFilter,'visible','On');
    set(handles.medianFilter,'visible','On');
    set(handles.boxSize,'visible','On');
    set(handles.gaussSize,'visible','On');
elseif (strcmp(eh_options,'Contrast Stretching'))
    set(handles.logFactor,'visible','Off');
    set(handles.logFactor_lbl,'visible','Off');
    set(handles.gamma,'visible','Off');
    set(handles.gamma_lbl,'visible','Off');
    set(handles.boxFilter,'visible','Off');
    set(handles.gaussianFilter,'visible','Off');
    set(handles.medianFilter,'visible','Off');
    set(handles.boxSize,'visible','Off');
    set(handles.gaussSize,'visible','Off');
elseif (strcmp(eh_options,'Sharpening'))
    set(handles.logFactor,'visible','Off');
    set(handles.logFactor_lbl,'visible','Off');
    set(handles.gamma,'visible','Off');
    set(handles.gamma_lbl,'visible','Off');
    set(handles.boxFilter,'visible','Off');
    set(handles.gaussianFilter,'visible','Off');
    set(handles.medianFilter,'visible','Off');
    set(handles.boxSize,'visible','Off');
    set(handles.gaussSize,'visible','Off');
end



% --- Executes during object creation, after setting all properties.
function enhance_options_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undo_btn.
function undo_btn_Callback(hObject, eventdata, handles)



% --- Executes on button press in Redo.
function Redo_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)



% --- Executes on button press in undo_btn.
function pushbutton10_Callback(hObject, eventdata, handles)




function logFactor_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function logFactor_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
global eh_options
global orignalImage
outputImage = orignalImage;
if (strcmp(eh_options,'Log Transformation'))
    image2= im2double(outputImage);
    temp=image2;
    [r,C]=size(image2);
    Logfactor = get(handles.logFactor,'String');
    if isempty(Logfactor)
     fprintf('Error: Enter Log Factor\n');
    else
        for i=1: r
         for j=1:C
         temp(i,j)=Logfactor*log(1+image2(i,j));
         end
        end
        axes(handles.enhanced_image);
        outputImage=temp
        imshow(outputImage);
    end
elseif (strcmp(eh_options,'Gamma Transformation'))
    image2= im2double(outputImage);
    temp2=image2;
    gammaFactor = get(handles.gamma,'String');
    gammaFactor = str2num(gammaFactor);
    if isempty(gammaFactor)
     fprintf('Error: Enter Gamma Factor\n');
    else
        h = imadjust(temp2,[],[],gammaFactor);
        axes(handles.enhanced_image);
        outputImage=h;
        imshow(outputImage);
    end 
elseif (strcmp(eh_options,'Contrast Stretching'))
    outputImage = histeq(outputImage);
    axes(handles.enhanced_image);
    imshow(outputImage);
elseif (strcmp(eh_options,'Smoothing'))
boxCheck = get(handles.boxFilter, 'Value');
gaussCheck = get(handles.gaussianFilter, 'Value');
medianCheck = get(handles.medianFilter, 'Value');
if(boxCheck==1)
    bSize = get(handles.boxSize,'String');
    boxImage = imboxfilt(outputImage,str2num(bSize));
    axes(handles.enhanced_image);
    imshow(boxImage);
elseif(gaussCheck==1)
    gSize = get(handles.gaussSize,'String');
    gaussImage = imgaussfilt(outputImage,str2num(gSize));
    axes(handles.enhanced_image);
    imshow(gaussImage);
elseif(medianCheck==1)
    medianImage = medfilt2(rgb2gray(outputImage));
    axes(handles.enhanced_image);
    imshow(medianImage);
end
elseif (strcmp(eh_options,'Image Negative'))
    L=256;
    outputImage=(L-1)-outputImage; 
    axes(handles.enhanced_image);
    imshow(outputImage);
elseif (strcmp(eh_options,'Sharpening'))
    h=fspecial('unsharp');
    outputImage=imfilter(outputImage,h);
    axes(handles.enhanced_image);
    imshow(outputImage);
end

function gamma_Callback(~, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in boxFilter.
function boxFilter_Callback(hObject, ~, handles)



% --- Executes on button press in gaussianFilter.
function gaussianFilter_Callback(hObject, eventdata, handles)


% --- Executes on button press in medianFilter.
function medianFilter_Callback(hObject, eventdata, handles)




function boxSize_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function boxSize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussSize_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function gaussSize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_btn.
function save_btn_Callback(hObject, eventdata, handles)
savedImage = getframe(handles.enhanced_image) ;
imwrite(savedImage.cdata,'output.jpg','jpg')
