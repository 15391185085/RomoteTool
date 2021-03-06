; -----------------------------
; Generated by the ENVI Modeler
; ENVI 5.5.2, API 3.4
; 测试
; 去除掉不规则黑边
; -----------------------------
pro test_delete_black_frame
  compile_opt idl2, hidden
  on_error, 2
  e = ENVI()

  aggregator_1 = Dictionary()
  aggregator_1.output = !null
  list_aggregator_1 = List()
  print,'处理开始'
  ; ---------------------------------------------
  ; GF2_E112_2_N42_2_20180610_19_fus_dat_R2C1.dat
  ; ---------------------------------------------
  filename = 'C:\Temp\2018\jg\GF2_E112_2_N42_2_20180610_19_fus_dat_R2C1.dat'
  raster_1 = e.OpenRaster(filename)

  ; ---------
  ; Band Math
  ; ---------
  task_1 = ENVITask('PixelwiseBandMathRaster')
  task_1.input_raster = raster_1
  task_1.expression = 'byte((b1 lt 10)*0+(b1 ge 10)*b1)'
  task_1.DATA_IGNORE_VALUE = 0
  task_1.Execute
  print,'处理1'
  ; ---------
  ; Band Math
  ; ---------
  task_2 = ENVITask('PixelwiseBandMathRaster')
  task_2.input_raster = raster_1
  task_2.expression = 'byte((b2 lt 10)*0+(b2 ge 10)*b2)'
  task_2.DATA_IGNORE_VALUE = 0
  task_2.Execute
  print,'处理2'
  ; ---------
  ; Band Math
  ; ---------
  task_3 = ENVITask('PixelwiseBandMathRaster')
  task_3.input_raster = raster_1
  task_3.expression = 'byte((b3 lt 10)*0+(b3 ge 10)*b3)'
  task_3.DATA_IGNORE_VALUE = 0
  task_3.Execute
  print,'处理3'
  ; ----------
  ; Aggregator
  ; ----------
  list_aggregator_1.Add, task_1.output_raster, /EXTRACT
  list_aggregator_1.Add, task_2.output_raster, /EXTRACT
  list_aggregator_1.Add, task_3.output_raster, /EXTRACT
  aggregator_1.output = list_aggregator_1

  ; -----------------
  ; Build Layer Stack
  ; -----------------
  task_4 = ENVITask('BuildLayerStack')
  task_4.input_rasters = aggregator_1.output
  task_4.resampling = 'Cubic Convolution'
  task_4.output_raster_uri = "C:\Temp\2018\jg\m2.dat"
  task_4.Execute
  print,'处理结束'
end
