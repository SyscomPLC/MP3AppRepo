 
 /*-----------------------------------------------------------------------
    File        : CountSheetDetail
    Syntax      : 
    Author(s)   : Dominic
    Created     : Wed Mar 16 11:49:46 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="CountSheetDetail.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="CountSheetDetail", URI="/CountSheetDetail", schemaName="dsCountSheetDetail", schemaFile="HPItemClassStockInfo/AppServer/countsheetdetail.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS CountSheetDetail INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"countsheetdetail.i"}
	
	DEFINE DATA-SOURCE srcCountSheetDetail FOR darwin.CountSheetDetail.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC CountSheetDetail():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsCountSheetDetail:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srcCountSheetDetail:HANDLE.
     	
     	     	
     	/* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
 	       ignored in create stmt */
     	    
     	cSkipListArray[1] = "".
     	
     	
     	THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
     	        
    END CONSTRUCTOR.
    	
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadCountSheetDetail(
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dsCountSheetDetail):
    		    
        
    	MESSAGE "in count sheet detail service - countsheetdetail.cls"
        VIEW-AS ALERT-BOX.
    	/*SUPER:ReadData(filter).*/
    	
    	/*FIND FIRST ttCountSheetDetail NO-LOCK NO-ERROR.
    	
    	IF AVAILABLE ttCountSheetDetail THEN DO:
    	    MESSAGE "Count sheet record not cleared: " ttCountSheetDetail.SheetNumber VIEW-AS ALERT-BOX.
    	END.*/

        
        EMPTY TEMP-TABLE ttCountSheetDetail.
        EMPTY TEMP-TABLE CountSheetDet.
        
        FIND FIRST ttCountSheetDetail NO-LOCK NO-ERROR.
        
        IF AVAILABLE ttCountSheetDetail THEN DO:
            MESSAGE "After- Count sheet record not cleared: " ttCountSheetDetail.SheetNumber VIEW-AS ALERT-BOX.
        END.
        
        MESSAGE "STBL reached from telerik app: " filter.
        
        BUFFER ttCountSheetDetail:ATTACH-DATA-SOURCE(DATA-SOURCE srcCountSheetDetail:HANDLE).   
                    
        /*IF filter NE "" AND filter NE ? THEN 
        DO:
           
            DATA-SOURCE srcCountSheetDetail:FILL-WHERE-STRING = filter.           
         
        END. */  
        
        IF filter NE "" AND filter NE ? THEN 
            DATA-SOURCE srcCountSheetDetail:FILL-WHERE-STRING = filter.               
        
        DATASET dsCountSheetDetail:FILL().
        
        /* we have all the CountSheetDetail records now filled uisng the filter */
        /*now go through each one and find the correct sheet number */
        FOR EACH ttCountSheetDetail NO-LOCK:
            
            MESSAGE "for each :" ttCountSheetDetail.QuantityOnHand VIEW-AS ALERT-BOX.
            
            
            /************* old code*************/
            /*CREATE CountSheetDet.
            ASSIGN CountSheetDet.InEntity       = ttCountSheetDetail.InEntity
                   CountSheetDet.WarehouseCode  = ttCountSheetDetail.WarehouseCode
                   CountSheetDet.ItemCode       = ttCountSheetDetail.ItemCode
                   CountSheetDet.SheetNumber    = ttCountSheetDetail.SheetNumber
                   CountSheetDet.QuantityOnHand = ttCountSheetDetail.QuantityOnHand
                   CountSheetDet.Storage        = ttCountSheetDetail.Storage
                   CountSheetDet.SubStorage     = ttCountSheetDetail.SubStorage
                   CountSheetDet.CountNumber    = ttCountSheetDetail.CountNumber.*/
              
            /************end old code **********************/
            
            
           /************ new fix ***********************************/
           
            /* to find the correct sheet we need to look at the CountItemClass where item has not been moved*/ 
            FIND FIRST CountItemClass
                WHERE CountItemClass.InEntity      = ttCountSheetDetail.InEntity
                AND   CountItemClass.WarehouseCode = ttCountSheetDetail.WarehouseCode
                AND   CountItemClass.Itemcode      = ttCountSheetDetail.ItemCode
                AND   CountItemClass.SheetNumber   = ttCountSheetDetail.SheetNumber
                AND   CountItemClass.Storage       = ttCountSheetDetail.Storage
                AND   CountItemClass.SubStorage    = ttCountSheetDetail.SubStorage
                AND   CountItemClass.CountNumber   = ttCountSheetDetail.CountNumber
                AND   CountItemClass.ItemMoved     = FALSE 
                NO-LOCK NO-ERROR.
                
                
                 
            /* we have found the countitemclass record we needed , now create the CountSheetDet and leave the */
            /* loop so we only have 1 record*/
            IF AVAILABLE CountItemClass THEN 
            DO:
                CREATE CountSheetDet.
                ASSIGN CountSheetDet.InEntity       = ttCountSheetDetail.InEntity
                       CountSheetDet.WarehouseCode  = ttCountSheetDetail.WarehouseCode
                       CountSheetDet.ItemCode       = ttCountSheetDetail.ItemCode
                       CountSheetDet.SheetNumber    = ttCountSheetDetail.SheetNumber
                       CountSheetDet.QuantityOnHand = ttCountSheetDetail.QuantityOnHand
                       CountSheetDet.Storage        = ttCountSheetDetail.Storage
                       CountSheetDet.SubStorage     = ttCountSheetDetail.SubStorage
                       CountSheetDet.CountNumber    = ttCountSheetDetail.CountNumber.
                LEAVE.                 
            END.  
            
            /*******************end of new fix **/  
        END.
        
        EMPTY TEMP-TABLE ttCountSheetDetail. 

        /*we only have one record here , find it again*/        
        FIND FIRST CountSheetDet NO-LOCK NO-ERROR.
        
        IF AVAILABLE CountSheetDet THEN DO:
            MESSAGE "find first: " CountSheetDet.SheetNumber CountSheetDet.InEntity
                    CountSheetDet.WarehouseCode CountSheetDet.Storage CountSheetDet.SubStorage  VIEW-AS ALERT-BOX.
                    
            MESSAGE CountSheetDet.QuantityOnHand VIEW-AS ALERT-BOX.
            CREATE ttCountSheetDetail.
            ASSIGN ttCountSheetDetail.InEntity          = CountSheetDet.InEntity 
                   ttCountSheetDetail.WarehouseCode     = CountSheetDet.WarehouseCode  
                   ttCountSheetDetail.ItemCode          = CountSheetDet.ItemCode
                   ttCountSheetDetail.SheetNumber       = CountSheetDet.SheetNumber
                   ttCountSheetDetail.QuantityOnHand    = CountSheetDet.QuantityOnHand
                   ttCountSheetDetail.Storage           = CountSheetDet.Storage 
                   ttCountSheetDetail.SubStorage        = CountSheetDet.SubStorage
                   ttCountSheetDetail.CountNumber       = CountSheetDet.CountNumber.
                   
            FIND Item NO-LOCK
               WHERE Item.InEntity = ttCountSheetDetail.InEntity
                 AND Item.ItemCode = ttCountSHeetDetail.ItemCode
                 NO-ERROR.

            FIND UOM NO-LOCK
                WHERE Uom.UomCode = Item.UomCode 
                NO-ERROR.
                
            IF AVAIL Uom THEN DO:
                ASSIGN ttCountSheetDetail.QuantityOnHand  = ttCountSheetDetail.QuantityOnHand / Uom.Unit                       
                       .
            END.      
            
            FIND CountSheet
                WHERE CountSheet.InEntity      = CountSheetDet.InEntity
                AND   CountSheet.WarehouseCode = CountSheetDet.WarehouseCode
                AND   CountSheet.SheetNumber   = CountSheetDet.SheetNumber
                NO-LOCK NO-ERROR.
            IF AVAILABLE (CountSheet) THEN
                ASSIGN ttCountSheetDetail.SheetDate = STRING(CountSheet.SheetDate, "99/99/9999").   

            
        END.
        
        FOR EACH ttCountsheetdetail NO-LOCK:
            MESSAGE "in for each - after create ttcousheetdetail.sheetdate = "  ttcountsheetdetail.Sheetdate
            VIEW-AS ALERT-BOX.
        END.     
        
        
        BUFFER ttCountSheetDetail:DETACH-DATA-SOURCE().
    	      
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateCountSheetDetail(INPUT-OUTPUT DATASET dsCountSheetDetail):    		
    	       
        SUPER:CreateData(DATASET dsCountSheetDetail BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateCountSheetDetail(INPUT-OUTPUT DATASET dsCountSheetDetail):    		
	
        SUPER:UpdateData(DATASET dsCountSheetDetail BY-REFERENCE).          
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteCountSheetDetail(INPUT-OUTPUT DATASET dsCountSheetDetail):     		       
	
        SUPER:DeleteData(DATASET dsCountSheetDetail BY-REFERENCE).
    END METHOD.
	 
    
END CLASS.
