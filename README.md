## Description
This code takes in jpegs and tifs of Masson's trichrome stained images and uses color deconvolution to quantify the percent volume of myocardium (pink), fibrosis (blue), and interstitial space (white) in a defined area.

## System Requirements
This Masson's trichrome analysis software requires Matlab. 
* Operating systems tested: Windows 10 and MacOS 10.5 Catalina
* Matlab versions tested: 2018, 2019 
* Matlab add-ons required: Image Processing Toolbox
No strict hardware requirements at this time.

## Installation Guide
As mentioned in the system requirements, this software must be run with Matlab. Download the Matlab files **MassonTrichromeAnalysis.fig** and **MassonTrichromeAnalysis.m**. This download should only take a few minutes.

## Instructions for use
1. Make sure that both files are in the same folder and that the Matlab file path is set to that folder. 
2. Run **MassonTrichromeAnalysis.m**. The GUI for the analysis should instantly pop up. 
3. In the GUI, select *Load Image File* which will prompt you to select your Masson's trichrome image. Images can be either jpegs or tifs. 
4. Click *open* to load the image. The name of the file should appear in the top righthand corner of the GUI.
5.  Click *reset RGB* to select the reference colors. **The order of the reference colors must be WHITE, then PINK, then BLUE.** We suggest that users select colors that are the median color for that reference range because the software will detect pixel RGB values that are within +/- a certain range of your reference. For example, for the blue color, choose a blue that is not too dark and not too light. 
6. Click *Select Area* to outline the area of interest. Double click at the end to finalize area selection.
7. Click *Analyze*. The analysis will take a few minutes.
8. The resultant volume percentages of red, blue, and white pixels relative to the reference values selected will be outputted in the GUI. 

## Demo
The following publications used this software:
1. Gutruf, P. et al. Nat. Commun. 10, 5742, 5742 (2019): https://doi.org/10.1038/s41467-019-13637-w 

2. Choi, Y.S. et al. Nat. Biotechnol. 39, 1228–1238 (2021): https://doi.org/10.1038/s41587-021-00948-x 

3. Yang, Q. et al. Nat. Mater. 20, 1559–1570 (2021): https://doi.org/10.1038/s41563-021-01051-x 

4. Choi, Y.S. et al. Science. 376, 6596, 1006-1012 (2022): https://doi.org/10.1126/science.abm1703 