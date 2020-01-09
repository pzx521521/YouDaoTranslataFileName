object frmTranslataFileName: TfrmTranslataFileName
  Left = 0
  Top = 0
  Caption = 'frmTranslataFileName'
  ClientHeight = 399
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lst1: TcxTreeList
    Left = 0
    Top = 81
    Width = 706
    Height = 318
    Align = alClient
    Bands = <
      item
      end>
    Navigator.Buttons.CustomButtons = <>
    OptionsView.ColumnAutoWidth = True
    TabOrder = 0
    ExplicitLeft = 152
    ExplicitTop = 88
    ExplicitHeight = 399
    object lst1Column1: TcxTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.GlyphAlignHorz = taCenter
      Caption.Text = #36335#24452#21069#32512
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object lst1Column2: TcxTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.GlyphAlignHorz = taCenter
      Caption.Text = #21517#23383
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object lst1Column3: TcxTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.GlyphAlignHorz = taCenter
      Caption.Text = #21518#32512#21517
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object lst1Column4: TcxTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.GlyphAlignHorz = taCenter
      Caption.Text = #32763#35793#21518#30340#21517#23383
      DataBinding.ValueType = 'String'
      Width = 114
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 81
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 64
    ExplicitTop = 128
    object lbl1: TLabel
      Left = 6
      Top = 20
      Width = 140
      Height = 13
      Caption = #36335#24452'('#21487#20197#25302#25991#20214#25110#25991#20214#22841')'
    end
    object lbl2: TLabel
      Left = 6
      Top = 45
      Width = 98
      Height = 13
      Caption = #21518#32512#21517'('#20840#37096#35831#20889'*)'
    end
    object edt1: TEdit
      Left = 160
      Top = 15
      Width = 375
      Height = 21
      TabOrder = 0
    end
    object edt2: TEdit
      Left = 160
      Top = 42
      Width = 73
      Height = 21
      TabOrder = 1
      Text = 'map'
    end
    object btn1: TButton
      Left = 239
      Top = 42
      Width = 75
      Height = 25
      Caption = #25628#32034#25991#20214
      TabOrder = 2
      OnClick = btn1Click
    end
    object btn2: TButton
      Left = 332
      Top = 42
      Width = 75
      Height = 25
      Caption = #24320#22987#32763#35793
      TabOrder = 3
      OnClick = btn2Click
    end
    object btn3: TButton
      Left = 573
      Top = 17
      Width = 108
      Height = 50
      Caption = #25209#37327#37325#21629#21517
      TabOrder = 4
      OnClick = btn3Click
    end
  end
end
