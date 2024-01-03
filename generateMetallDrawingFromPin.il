procedure(CopyMetalPinToDrawing(@key (cvId geGetEditCellView()) (fromLayer "METAL1") (fromPurpose "pin")
    (toLayer "METAL1") (toPurpose "drawing"))
let((srcLPP newShape)
  srcLPP=car(exists(LPP cvId~>lpps LPP~>layerName==fromLayer && LPP~>purpose==fromPurpose))
  foreach(shape srcLPP~>shapes
    newShape=dbCopyFig(shape cvId)
    newShape~>layerName=toLayer
    newShape~>purpose=toPurpose
  )
  t
)
)
libId=ddGetObj("tcb018gbwp7t_new")
counterOther = 1
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("abstract"			
				printf("%d Cell %s found\n", counterOther, cell->name)
				counterOther = counterOther + 1
				cvId = dbOpenCellViewByType( libId->name cell->name "abstract" "" "a")
				CopyMetalPinToDrawing(?cvId cvId ?fromLayer "METAL1" ?fromPurpose "pin" ?toLayer "METAL1" ?toPurpose "drawing")
				dbSave(cvId)
			)
			( t				
			)
		)
	)
)