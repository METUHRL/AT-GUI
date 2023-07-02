function h = map_voltage_on_geom(PTS,FAC,Data, title_char_vec, if_node_num, PaceLoc)
    x = PTS(:,1);
    y = PTS(:,2);
    z = PTS(:,3);
    h = trisurf(FAC,x,y,z,Data);
%     set(h,'Facecolor','Interp','EdgeColor','Interp','FaceAlpha',0.5)
    set(h,'Facecolor','Interp','EdgeColor','Interp')
    xticks([])
    yticks([])
    zticks([])
    grid off
    ax = gca;
    axis(ax,'off');
    hold on 

    
    if nargin > 5                                                      
        hpaceloc = scatter3(x(PaceLoc),y(PaceLoc),z(PaceLoc),100,'yellow','filled');
    end

    if if_node_num
        textscatter3(x,y,z,string((1:length(x))'))
    end
    
%     legend(hpaceloc,'Pacing Location')

    datatip(h,0,0,0);
    row =  dataTipTextRow('Nnum =',FAC');
    h.DataTipTemplate.DataTipRows(end+1) = row;

    DataMapping = arrayfun(@(x) Data(x), FAC);

    row =  dataTipTextRow('AT =',DataMapping');
    h.DataTipTemplate.DataTipRows(end+1) = row;

    colormap jet
    title(title_char_vec,'Interpreter','latex','FontSize',20)
end
