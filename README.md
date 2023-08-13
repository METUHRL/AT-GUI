# Activation Time GUI
## Implementation 
The project consists of 2 main scripts: [AT_GUI.mlapp](https://github.com/METUHRL/AT-GUI/blob/master/AT_GUI.mlapp).
The individual functions can be found in [functions](https://github.com/METUHRL/AT-GUI/tree/master/functions) file. 
## Graphical User Interface
![GUI_bos_TAB1_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/0807def8-e838-4e3e-9655-86a6bb4e94bb)
### Usage

* Load the data by pressing the <ins>Load</ins> button and choose epicardial potentials in the <ins>Epicardial Potentials</ins> dropdown menu. 
* Enter the starting (Q) and end (S) indices of the QRS region.
* Choose the activation time from the loaded file if it exists; otherwise, check the "AT is not precomputed" and choose the AT method.
* After setting the earliest activated ratio press the <ins>Plot</ins> button.
![GUI_bos_TAB2_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/225dcd51-4de0-4421-8dd6-5471def09235)
* Press <ins>Show</ins> to see where the labeled time instance corresponds to in the ECG signal.
* Press <ins>Save</ins> to save the labeled time instance in the ECG signal.
* Press <ins>Defective</ins> if the lead contains artifacts.
* Press <ins>Overwrite</ins> to save over the file.
* Press <ins>Map on Geometry</ins> to plot the spatial distribution of AT.
![GUI_Spatially_Coherent_TAB3_yeni](https://github.com/METUHRL/AT-GUI/assets/83376963/11622e40-ca97-408f-9042-6062fb0de2fc)
* In this tab, you can modify the AT instances by entering the node number and pressing the <ins>Plot</ins> button.
* Press <ins>Overwrite</ins> to save over the file. 


| :warning: INFO & WARNINGS  |
|:---------------------------|
| The geometry file should include only one coordinate and triangulation matrices. | 
| The script utilized dictionaries. They require MATLAB version R2022b at least. | 

