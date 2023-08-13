# Activation Time GUI
## Implementation 
The project consists of 2 main scripts: [AT_GUI.mlapp](https://github.com/METUHRL/AT-GUI/blob/master/AT_GUI.mlapp).
The individual functions can be found in [functions](https://github.com/METUHRL/AT-GUI/tree/master/functions) file. 
## Graphical User Interface

### Usage

![GUI_bos_TAB1_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/b0c34356-209b-41ee-beb8-7d55f84a4c73)

* Load the data by pressing the <ins>Load</ins> button and choose epicardial potentials in the <ins>Epicardial Potentials</ins> dropdown menu. 
* Enter the starting (Q) and end (S) indices of the QRS region.
* Choose the activation time from the loaded file if it exists; otherwise, check the "AT is not precomputed" and choose the AT method.
* After setting the earliest activated ratio press the <ins>Plot</ins> button.

![GUI_bos_TAB2_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/9649de72-d319-45d0-bb07-72e698c59229)

* Press <ins>Show</ins> to see where the labeled time instance corresponds to in the ECG signal.
* Press <ins>Save</ins> to save the labeled time instance in the ECG signal.
* Press <ins>Defective</ins> if the lead contains artifacts.
* Press <ins>Overwrite</ins> to save over the file.
* Press <ins>Map on Geometry</ins> to plot the spatial distribution of AT.

![GUI_Spatially_Coherent_TAB3_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/b99a29b3-cf1a-45ae-9189-8047e3c159ee)

* In this tab, you can modify the AT instances by entering the node number and pressing the <ins>Plot</ins> button.
* Press <ins>Overwrite</ins> to save over the file. 


| :warning: INFO & WARNINGS  |
|:---------------------------|
| The geometry file should include only one coordinate and triangulation matrices. | 
| The script utilized dictionaries. They require MATLAB version R2022b at least. | 

