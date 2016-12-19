object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 270
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 384
    Top = 21
    Width = 65
    Height = 25
    Caption = 'Importar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 272
    Top = 23
    Width = 106
    Height = 21
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 56
    Top = 23
    Width = 193
    Height = 21
    TabOrder = 2
    Text = 'test\Arquivo100.txt'
  end
  object Memo1: TMemo
    Left = 56
    Top = 64
    Width = 393
    Height = 177
    TabOrder = 3
  end
  object Button2: TButton
    Left = 208
    Top = 21
    Width = 41
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 472
    Top = 72
  end
end
