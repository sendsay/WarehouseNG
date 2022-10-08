object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 279
  Width = 489
  object conMain: TFDConnection
    Params.Strings = (
      'DriverID=MSAcc')
    LoginPrompt = False
    AfterConnect = conMainAfterConnect
    Left = 133
    Top = 27
  end
  object fdqryItems: TFDQuery
    Connection = conMain
    SQL.Strings = (
      'SELECT * FROM Items WHERE ID_Item='#39'PUUTINHUILLO'#39)
    Left = 77
    Top = 91
    object fdtncfldItemsID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object wdstrngfldItemsID_Item: TWideStringField
      FieldName = 'ID_Item'
      Origin = 'ID_Item'
      Size = 255
    end
    object wdstrngfldItemsName_Item: TWideStringField
      FieldName = 'Name_Item'
      Origin = 'Name_Item'
      Size = 255
    end
    object intgrfldItemsQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object wdstrngfldItemsMachine: TWideStringField
      FieldName = 'Machine'
      Origin = 'Machine'
      Size = 255
    end
    object wdstrngfldItemsNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'Notes'
      Size = 255
    end
    object blbfldItemsPhoto: TBlobField
      FieldName = 'Photo'
      Origin = 'Photo'
    end
  end
  object dsItems: TDataSource
    DataSet = fdqryItems
    Left = 176
    Top = 88
  end
  object fdgxwtcrsrMain: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 360
    Top = 24
  end
  object fdphysqltdrvrlnkMain: TFDPhysSQLiteDriverLink
    Left = 360
    Top = 88
  end
  object fdqryUsers: TFDQuery
    Connection = conMain
    SQL.Strings = (
      'SELECT * FROM Users')
    Left = 72
    Top = 160
    object fdtncfldUsersID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqryUsersUserName: TWideStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 255
    end
    object fdqryUsersUserPass: TWideStringField
      FieldName = 'UserPass'
      Origin = 'UserPass'
      Size = 255
    end
    object wdstrngfldUsersMachine: TWideStringField
      FieldName = 'Machine'
      Origin = 'Machine'
      Size = 255
    end
  end
  object dsUsers: TDataSource
    DataSet = fdqryUsers
    Left = 176
    Top = 152
  end
end
