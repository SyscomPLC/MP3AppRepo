 
 /*------------------------------------------------------------------------
    File        : MobilePutaway
    Syntax      : 
    Author(s)   : swarn
    Created     : Wed May 04 15:48:19 BST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="MobilePutaway.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="MobilePutaway", URI="/MobilePutaway", schemaName="dsItemClassStock", schemaFile="HPItemClassStockInfo/AppServer/mobileputaway.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS MobilePutaway INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"mobileputaway.i"}
	
	DEFINE DATA-SOURCE srcItemClassStock FOR darwin.ItemClassStock.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC MobilePutaway():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsItemClassStock:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srcItemClassStock:HANDLE.
     	
     	     	
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
    METHOD PUBLIC VOID ReadMobilePutaway(          
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dsItemClassStock):    		    
           	
    	DEFINE VARIABLE lMoveFullQuantity AS LOGICAL   NO-UNDO.
        DEFINE VARIABLE dQtyAlloc         AS DECIMAL   NO-UNDO.    
        DEFINE VARIABLE dQtyOnHand        AS DECIMAL   NO-UNDO.
        DEFINE VARIABLE dQtyOnPPS         AS DECIMAL   NO-UNDO.
        DEFINE VARIABLE dQtyDesp          AS DECIMAL   NO-UNDO.
        DEFINE VARIABLE cError            AS CHARACTER NO-UNDO.
        DEFINE VARIABLE lFirstRun         AS LOGICAL   NO-UNDO.
        DEFINE VARIABLE pcUserId          AS CHARACTER NO-UNDO.
        DEFINE VARIABLE pcUserPassword    AS CHARACTER NO-UNDO.
                        
        ASSIGN lFirstRun      = TRUE
               pcUserID       = ""
               pcUserPassword = "" 
               .

        MESSAGE "filter = " filter VIEW-AS ALERT-BOX.

        EMPTY TEMP-TABLE ttItemClassStock.
        
        /*filter = "WHERE ItemCode BEGINS 'DAN300LRED'".*/ 
                    
        
        MESSAGE "read putaway - PA reached from telerik app" filter.
        
        BUFFER ttItemClassStock:ATTACH-DATA-SOURCE(DATA-SOURCE srcItemClassStock:HANDLE).   
                    
        IF filter NE "" AND filter NE ? THEN 
            DATA-SOURCE srcItemClassStock:FILL-WHERE-STRING = filter.               
            
        DATASET dsItemClassStock:FILL().
            
        FOR EACH ttItemClassStock NO-LOCK:              
                                 
            FIND Item NO-LOCK
               WHERE Item.InEntity = ttItemClassStock.InEntity
                 AND Item.ItemCode = ttItemClassStock.ItemCode
                 NO-ERROR.
              
            IF AVAIL Item THEN DO:                
                
                FIND UOM NO-LOCK
                    WHERE Uom.UomCode = Item.UomCode 
                    NO-ERROR.
                    
                IF AVAIL Uom THEN DO:
                    
                    IF lFirstRun THEN DO:
                        
                        {"LoginJobQueue.i"}
                        RUN "services/mobile/GetMoveFullQty.p" ON SERVER hSer
                           (INPUT  ttItemClassStock.InEntity,                                                
                            OUTPUT lMoveFullQuantity,
                            OUTPUT cError).
                        {"LogOutJobQueue.i"}   
                        ASSIGN lFirstRun = FALSE.                     
                    END.
                                                            
                    /*MESSAGE lMoveFullQuantity ttItemClassStock.InEntity cError VIEW-AS ALERT-BOX.-*/
                    IF lMoveFullQuantity THEN DO: 
                        
                       ASSIGN ttItemClassStock.UserField11 = TRIM(STRING(TRUNCATE(ttItemClassStock.QuantityOnHand / Uom.Unit,0) + (ttItemClassStock.QuantityOnHand / Uom.Unit - TRUNCATE (ttItemClassStock.QuantityOnHand / Uom.Unit,0))* Uom.Unit / Uom.ExpDecimal,uom.mask)).
                              ttItemClassStock.UserField14 = ttItemClassStock.UserField11.
                    END.
                    ELSE DO:                        
                                                               
                        ASSIGN dQtyAlloc  = DEC(TRUNCATE(ttItemClassStock.QuantityAlloc / Uom.Unit,0) + (ttItemClassStock.QuantityAlloc / Uom.Unit - TRUNCATE (ttItemClassStock.QuantityAlloc / Uom.Unit,0))* Uom.Unit / Uom.ExpDecimal)                    
                               dQtyOnHand = DEC(TRUNCATE(ttItemClassStock.QuantityOnHand / Uom.Unit,0) + (ttItemClassStock.QuantityOnHand / Uom.Unit - TRUNCATE (ttItemClassStock.QuantityOnHand / Uom.Unit,0))* Uom.Unit / Uom.ExpDecimal)
                               dQtyOnPPS  = DEC(TRUNCATE(ttItemClassStock.QuantityOnPps / Uom.Unit,0) + (ttItemClassStock.QuantityOnPps / Uom.Unit - TRUNCATE (ttItemClassStock.QuantityOnPps / Uom.Unit,0))* Uom.Unit / Uom.ExpDecimal).
                               dQtyDesp   = DEC(TRUNCATE(ttItemClassStock.DespatchNoteQty / Uom.Unit,0) + (ttItemClassStock.DespatchNoteQty / Uom.Unit - TRUNCATE (ttItemClassStock.DespatchNoteQty / Uom.Unit,0))* Uom.Unit / Uom.ExpDecimal).
                               .
                        ASSIGN ttItemClassStock.UserField11 = TRIM(STRING(dQtyOnHand - dQtyAlloc - dQtyOnPPS - dQtyDesp,uom.mask))
                               ttItemClassStock.UserField14 = TRIM(STRING(dQtyOnHand - dQtyAlloc - dQtyOnPPS - dQtyDesp,uom.mask)).  
                                   
                  
                    END.                 
                                    
                END.   
            END.             

        END.
        
        BUFFER ttItemClassStock:DETACH-DATA-SOURCE().
    	      
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateMobilePutaway(INPUT-OUTPUT DATASET dsItemClassStock):    		
    	       
        SUPER:CreateData(DATASET dsItemClassStock BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateMobilePutaway(INPUT-OUTPUT DATASET dsItemClassStock):    		
	
    DEFINE VARIABLE cError          AS CHARACTER NO-UNDO.
    DEFINE VARIABLE dMoveQty        AS DECIMAL   NO-UNDO.
    DEFINE VARIABLE dTest           AS DECIMAL   NO-UNDO.
    DEFINE VARIABLE dTest2          AS DECIMAL   NO-UNDO.   


        /*SUPER:UpdateData(DATASET dsItemStock BY-REFERENCE).*/
        
        MESSAGE "PUTAWAY UPDATE" VIEW-AS ALERT-BOX.
        
        DEFINE VAR hDataSet AS HANDLE NO-UNDO.
        hDataSet = DATASET dsItemClassStock:HANDLE.
       
        /*THIS-OBJECT:CommitCustomers(INPUT "", ROW-MODIFIED).*/ 
        
        DISABLE TRIGGERS FOR LOAD OF ItemClassStock. 
        
        /*THIS-OBJECT:CreateRegionWithDAC().*/
        
        FIND FIRST ttItemClassStock.
        
        MESSAGE "ImpLogic: " ttItemClassStock.UserField10
            VIEW-AS ALERT-BOX.       
        
        IF AVAILABLE ttItemClassStock THEN DO:
            
            ASSIGN pcUserId = ttItemClassStock.UserField10.
                           
            FIND Item NO-LOCK
               WHERE Item.InEntity = ttItemClassStock.InEntity
                 AND Item.ItemCode = ttItemClassStock.ItemCode
                 NO-ERROR.
              
            IF AVAIL Item THEN DO:
                FIND UOM NO-LOCK
                    WHERE Uom.UomCode = Item.UomCode 
                    NO-ERROR.
                     
                IF AVAIL Uom THEN DO:
                    
                    ASSIGN dTest = DEC(ttItemClassStock.UserField14) * DEC(Uom.Unit)  
                           dTest2 = DEC(ttItemClassStock.UserField11) * DEC(Uom.Unit).                                                         
                END.     
                           
            END.             
                       
            /*run on the erp server through jobqueue*/   
            MESSAGE "Putaway Test: " pcUserId pcUserPassword
            VIEW-AS ALERT-BOX.
            MESSAGE ttItemClassStock.Storage dTest dTest2 ttItemClassStock.UserField12 VIEW-AS ALERT-BOX.         
            
            {"LoginJobQueue.i"}
             RUN "services/mobile/MobilePuttaway.p" ON SERVER hSer
                (INPUT  ttItemClassStock.InEntity,
                 INPUT  ttItemClassStock.Itemcode,
                 INPUT  ttItemClassStock.WarehouseCode,  /*old whs*/
                 INPUT  ttItemClassStock.UserField15,    /*new whs*/
                 INPUT  ttItemClassStock.Identifier,                 
                 INPUT  ttItemClassStock.SubIdentifier,
                 INPUT  ttItemClassStock.Storage,        /*old storage*/
                 INPUT  ttItemClassStock.UserField12,    /*new storage*/
                 INPUT  ttItemClassStock.Substorage,     /*old substorage*/
                 INPUT  ttItemClassStock.UserField13,    /*new substorage*/                 
                 INPUT  STRING(dTest2), /*STRING(ttItemClassStock.QuantityOnHand),*/  /*qty in inspaection*/
                 INPUT  STRING(dTest),/*ttItemClassStock.UserField14,*/    /*qty moved out of insp*/                       
                 OUTPUT cError).
            {"LogOutJobQueue.i"}           
 
            MESSAGE cError VIEW-AS ALERT-BOX.
            
        END.
                    
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteMobilePutaway(INPUT-OUTPUT DATASET dsItemClassStock):     		       
	
        SUPER:DeleteData(DATASET dsItemClassStock BY-REFERENCE).
    END METHOD.
	 
    
END CLASS.
