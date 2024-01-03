libId=ddGetObj("tcb018gbwp7t")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("symbol" 
			if(dbOpenCellViewByType(libId->name cell->name "schematic" "" "r") then
				printf("schematic already exists, adding Supply Pins and update symbol\n")
				cvId = dbOpenCellViewByType( libId->name cell->name "schematic" "" "a")
				pinMaster=dbOpenCellViewByType("basic" "iopin" "symbol")
				schCreatePin(cvId pinMaster "VSS" "inputOutput" nil 1:0.2 "R0")
				schCreatePin(cvId pinMaster "VDD" "inputOutput" nil 1:0 "R0")
				errs = schCheck( cvId )
				dbSave(cvId)
				pinList=schSchemToPinList(libId->name cell->name "schematic")
				cvDelID = ddGetObj(libId->name cell->name "symbol")
				ddDeleteObj(cvDelID)
				schPinListToView(libId->name cell->name "symbol" pinList "schPinListToSymbolGen")
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
			("abstract"
			if(dbOpenCellViewByType(libId->name cell->name "symbol" "" "r") then
			else
				printf("only abstract, adding Supply Pins in schematic and update symbol\n")
				cvId = dbOpenCellViewByType( libId->name cell->name "schematic" "schematic" "a")
				pinMaster=dbOpenCellViewByType("basic" "iopin" "symbol")
				schCreatePin(cvId pinMaster "VSS" "inputOutput" nil 1:0.2 "R0")
				schCreatePin(cvId pinMaster "VDD" "inputOutput" nil 1:0 "R0")
				symbolId = dbOpenCellViewByType( "analogLib" "res" "symbol" "" 'r )
				instId = schCreateInst( cvId symbolId "RDUMMY" 0:0 "R0" )
				errs = schCheck( cvId )
				dbSave(cvId)
				pinList=schSchemToPinList(libId->name cell->name "schematic")
				;cvDelID = ddGetObj(libId->name cell->name "symbol")
				;ddDeleteObj(cvDelID)
				schPinListToView(libId->name cell->name "symbol" pinList "schPinListToSymbolGen")
			)
			)
			(t)
		)
	)
)

