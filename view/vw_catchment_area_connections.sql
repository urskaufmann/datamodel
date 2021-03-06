﻿DROP VIEW IF EXISTS qgep.vw_catchment_area_connections;

CREATE VIEW qgep.vw_catchment_area_connections AS
SELECT

ca.obj_id,
ST_MakeLine(ST_Centroid(ST_CurveToLine(perimeter_geometry)),
wn_rw_current.situation_geometry)::geometry( LineString, :SRID ) AS connection_rw_current_geometry,
ST_MakeLine(ST_Centroid(ST_CurveToLine(perimeter_geometry)),
wn_ww_current.situation_geometry)::geometry( LineString, :SRID ) AS connection_ww_current_geometry

FROM qgep.od_catchment_area ca
LEFT JOIN qgep.od_wastewater_node wn_rw_current
ON ca.fk_wastewater_networkelement_rw_current = wn_rw_current.obj_id
LEFT JOIN qgep.od_wastewater_node wn_ww_current
ON ca.fk_wastewater_networkelement_ww_current = wn_ww_current.obj_id;
