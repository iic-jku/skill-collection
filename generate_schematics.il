libId=ddGetObj("tcb018gbwp7t")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("symbol" 
			if(dbOpenCellViewByType(libId->name cell->name "schematic" "" "r") then
				;printf("schematic already exists \n")
			else
				if(dbOpenCellViewByType(libId->name cell->name "abstract") then
					if(dbOpenCellViewByType(libId->name cell->name "symbol") then
						schViewToView(libId->name cell->name libId->name cell->name "symbol" "schematic" "schSymbolToPinList" "schPinListToSchem")
						cvId = dbOpenCellViewByType( libId->name cell->name "schematic" "" "a")
						symbolId = dbOpenCellViewByType( "analogLib" "res" "symbol" "" 'r )
						instId = schCreateInst( cvId symbolId "RDUMMY" 0:0 "R0" )
						errs = schCheck( cvId )
					else
						printf("Skip Cell as just a abstract/fill ")
					)
				else
					printf("Skip Cell as just a symbol/pin ")
				)
			)		
			)
			(t)
		)
	)
)

