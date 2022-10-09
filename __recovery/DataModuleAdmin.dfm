object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 384
  Width = 622
  object dsUsers: TDataSource
    DataSet = fdqryUsers
    OnDataChange = dsUsersDataChange
    Left = 152
    Top = 96
  end
  object conMain: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projects\Delphi\WarehouseNG\Win32\Debug\WareHouse.ac' +
        'cdb'
      'Password=Dell09061976'
      'DriverID=MSAcc')
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 32
  end
  object fdqryUsers: TFDQuery
    Active = True
    Connection = conMain
    SQL.Strings = (
      'SELECT * FROM Users')
    Left = 48
    Top = 96
    object fdtncfldUsersID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object wdstrngfldUsersUserName: TWideStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 255
    end
    object wdstrngfldUsersUserPass: TWideStringField
      FieldName = 'UserPass'
      Origin = 'UserPass'
      Size = 255
    end
    object intgrfldUsersMachine: TIntegerField
      FieldName = 'Machine'
      Origin = 'Machine'
    end
  end
  object fdqryMachine: TFDQuery
    Connection = conMain
    SQL.Strings = (
      'SELECT * FROM Machines')
    Left = 48
    Top = 160
    object fdtncfldMachineID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object wdstrngfldMachineMachineName: TWideStringField
      FieldName = 'MachineName'
      Origin = 'MachineName'
      Size = 255
    end
  end
  object dsMachine: TDataSource
    DataSet = fdqryMachine
    Left = 152
    Top = 160
  end
end
