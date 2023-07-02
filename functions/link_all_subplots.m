function f = link_all_subplots(f)
    allAxesInFigure = findall(f,'type','axes');
    hlinks = linkprop(allAxesInFigure',{'CameraPosition','CameraUpVector'});
    f.UserData = hlinks;
end