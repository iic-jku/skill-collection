libId=ddGetObj("tcb018gbwp7t")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("functional" 
				cvId = dbOpenCellViewByType( libId->name cell->name "functional" "" "a")					
				errs = vmsUpdateCellViews(?lib libId->name ?cell cell->name ?view "functional")
				dbSave(cvId)
				dbClose(cvId)
			)
		)
	)
)

libId=ddGetObj("tcb018gbwp7t")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("schematic" 
				cvId = dbOpenCellViewByType( libId->name cell->name "schematic" "" "a")					
				errs = schCheck( cvId )
				schExtractConn( cvId )
				dbSave(cvId)
				dbClose(cvId)
			)
		)
	)
)

libId=ddGetObj("tcb018gbwp7t")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("symbol" 
				cvId = dbOpenCellViewByType( libId->name cell->name "symbol" "" "a")					
				errs = schVIC(cvId)
				dbSave(cvId)
				dbClose(cvId)
			)
		)
	)
)

