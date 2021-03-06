function handles = ClearAllData(handles)
% ClearAllData is called by ExitDetector during application initialization
% and if the user presses "Clear All" to reset the UI and initialize all
% runtime data storage variables. Note that all checkboxes will get updated
% to their configuration default settings.
%
% Author: Mark Geurts, mark.w.geurts@gmail.com
% Copyright (C) 2017 University of Wisconsin Board of Regents
%
% This program is free software: you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the  
% Free Software Foundation, either version 3 of the License, or (at your 
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
% Public License for more details.
% 
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see http://www.gnu.org/licenses/.

% Log action
if isfield(handles, 'planUID')
    Event('Clearing patient plan variables from memory');
else
    Event('Initializing patient plan variables');
end

% planUID stores the UID of the analyzed patient plan as a string
handles.planUID = [];

% planData stores the delivery plan info as a structure. See LoadPlan
handles.planData = [];

% referenceImage stores the planning CT and structure set as a structure.
% See LoadImage and LoadStructures
handles.referenceImage = [];

% mergedImage stores the merged MVCT/kVCT for MVCT based calculation
% See MergeImages
handles.mergedImage = [];

% referenceDose stores the optimized plan dose as a structure. See
% LoadDose and UpdateDVH
handles.referenceDose = [];

% dqaDose stores the recomputed dose (using the measured sinogram) as a
% structure. See CalcDose and UpdateDVH
handles.dqaDose = [];

% doseDiff stores the absolute difference between the dqaDose and
% referenceDose as an array.  See CalcDoseDifference
handles.doseDiff = [];

% gamma stores the gamma comparison between the planned and recomputed 
% dose as an array. See CalcGamma
handles.gamma = [];

% rawData is a 643 x n array of compressed exit detector data.  See
% LoadStaticCouchQA
handles.rawData = [];

% exitData is a 64 x n array of measured de-convolved exit detector
% response for the patient plan. See CalcSinogramDiff
handles.exitData = [];

% diff is a 64 x n array of differences between the planned and measured
% sinogram data. See CalcSinogramDiff
handles.diff = [];

% errors is a vector of sinogram errors for all active leaves, used to
% compute statistics. See CalcSinogramDiff
handles.errors = [];

% Clear patient file string
set(handles.archive_file, 'String', '');

% Disable print and export buttons while patient data is unloaded
set(handles.print_button, 'Enable', 'off');
set(handles.export_button, 'Enable', 'off');

% Disabled dose calculation buttons
set(handles.calcdose_button, 'Enable', 'off'); 
set(handles.calcgamma_button, 'Enable', 'off'); 

% Hide plots
if isfield(handles, 'tcsplot')
    delete(handles.tcsplot);
else
    set(allchild(handles.dose_axes), 'visible', 'off'); 
    set(handles.dose_axes, 'visible', 'off');
    set(handles.dose_slider, 'visible', 'off');
    colorbar(handles.dose_axes,'off');
end
if isfield(handles, 'dvh')
    delete(handles.dvh);
else
    set(handles.dvh_table, 'Data', cell(16,6));
    set(allchild(handles.dvh_axes), 'visible', 'off'); 
    set(handles.dvh_axes, 'visible', 'off');
end
set(handles.dose_display, 'Value', 1);
set(handles.results_display, 'Value', 1);
set(allchild(handles.results_axes), 'visible', 'off'); 
set(handles.results_axes, 'visible', 'off');
set(handles.exportplot_button, 'enable', 'off');
set(allchild(handles.sino1_axes), 'visible', 'off'); 
set(handles.sino1_axes, 'visible', 'off');
colorbar(handles.sino1_axes,'off');
set(allchild(handles.sino2_axes), 'visible', 'off'); 
set(handles.sino2_axes, 'visible', 'off');
colorbar(handles.sino2_axes,'off');
set(allchild(handles.sino3_axes), 'visible', 'off'); 
set(handles.sino3_axes, 'visible', 'off');
colorbar(handles.sino3_axes,'off');

% Hide dose TCS/alpha
set(handles.tcs_button, 'visible', 'off');
set(handles.alpha, 'visible', 'off');

% Clear tables
set(handles.stats_table, 'Data', UpdateStatistics(handles));