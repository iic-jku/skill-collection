libId=ddGetObj("ts18ugfsdus")
foreach(cell libId->cells
	foreach(view cell->views
		case(view->name 
			("schematic"			
				printf("Cell %s found\n", cell->name)
				cv = dbOpenCellViewByType( libId->name cell->name "schematic" "" "a")
				i = 0
				foreach(instance cv~>instances
					if(instance~>cellName == "nm" || instance ~>cellName == "pm" then
						instance~>name = sprintf(nil "FET%d" i)
						foreach(prop instance~>prop
							if(prop~>name == "M" then
								cdf = cdfGetInstCDF(instance)
								foreach(param cdf~>parameters
									if(param~>name == "MX" then
										param~>value = prop~>value
									)
								)
							)
						)
						i = i + 1
					)
				)
				dbSetConnCurrent(cv)
				schCheck(cv)
				dbSave(cv)
				dbClose(cv)
			)
			( t				
			)
		)
	)
)