VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub delete_colnames()

Dim colNames_del
Dim i&, j&

'delete������
colNames_del = Array("CI��ʶ", "ϵͳ�ڵ�CI", "HostName", "DBʵ������", "�м��ʵ������", "��������", "Ӧ�÷���", "Ӧ�ýڵ�����", "Ӧ�÷�Χ", "Ӧ����", "Ӧ��״̬", "�ֱ��ȼ�", "�߿��ò���", "�߿���ģʽ", "��ȺIP��ַ", "�������ϵ", "������", "רҵ��", "Ӧ��ά������", "Ӧ��ά����", "����Χ", "��������", "�ڵ������", "Ӧ�ø߿���ģʽ", "��Դ���", "���к�", "�ͺ�", "������CPU����", "������CPU����", "�������ڴ�����", "������Ӳ�̹��G��", "����λ��", "��װ����", "�������", "�豸����CPU����", "�豸����CPU����", "�豸�����ڴ�����", "�豸��������Ӳ�̸���", "�豸����RAID����", "�豸�����洢����", "�洢�豸��Դ���", "�洢�豸���к�", "HostGroupName", "�洢��Դ����", "VIP��ַ", "VIP����", "CI�������", "CI������", "ϵͳ�ڵ�CI�������", "����ʱ��", "������ʱ��", "����޸���", "ά����Դ", "��ע", "������״̬")

For i = 1 To 80
    For j = 0 To UBound(colNames_del)
        If Cells(1, i) = colNames_del(j) Then
            Columns(i).Delete
        End If
    Next
Next

'����հ�IP
For i = 2 To 30000
    If Cells(i, 3) = "" Then
    Cells(i, 3) = Cells(i, 4).Value
    End If
Next


On Error Resume Next
    Application.ScreenUpdating = False
    Dim spcStr, arr, rend&, brr, rng As Range, icount&
    spcStr = Array("����һ", "�칫", "������֤", "Ͷ��׼��", "����������")
    rend = Range("A" & Rows.Count).End(xlUp).Row '���һ���ǿ��е�����
    arr = Range("A2:A" & rend) 'A�и�arr
    Dim arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8, arr9 As Range
    arr1 = Range("J2:J" & rend) 'arr1��Ӧ�ýڵ�����
    arr2 = Range("M2:M" & rend) 'arr2��Ʒ��
    arr3 = Range("Q2:Q" & rend) 'arr3��ϵͳ�ڵ�CI������
    arr4 = Range("N2:N" & rend) 'arr4�������
    arr5 = Range("H2:H" & rend) 'arr5��Ӧ��Ӣ�ļ��
    arr6 = Range("K2:K" & rend) 'arry6����������
    arr7 = Range("L2:L" & rend) 'С��
    arr8 = Range("O2:O" & rend) '��������
    ReDim brr(1 To UBound(arr), 1 To 1)  'brr(1-arr,1)��������Ƕ�Ӧ���Ƿ�����ؼ���
    icount = 0
    For i = 1 To UBound(arr)    '��һ�е����һ��ѭ��
        For j = 0 To UBound(spcStr) '��һ���ؼ��ֵ����һ���ؼ���ѭ��
            If InStr(arr(i, 1), spcStr(j)) > 0 Then   'ƥ��ؼ���
                brr(i, 1) = 1: icount = icount + 1
                GoTo nt
            End If
        Next
    If InStr(arr1(i, 1), "����") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr2(i, 1), "WDW") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr3(i, 1), "�������ģ��Ϻ���ϵͳ�Ĳ�") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr3(i, 1), "�������ģ��Ϻ���ϵͳ�Ĳ�") = 0 And InStr(arr3(i, 1), "�������ģ��Ϻ���ϵͳ����") = 0 And (InStr(arr4(i, 1), "�����") = 0 And InStr(arr4(i, 1), "�ζ�") = 0) Then     '����ŷ�ϵͳ3��4�ڵ�
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr5(i, 1), "ECCOPT") > 0 Or InStr(arr5(i, 1), "BF-CDS(DCCB)") > 0 Or (InStr(arr5(i, 1), "CDS") > 0 And InStr(arr5(i, 1), "F-CDSI") = 0) Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr6(i, 1), "�䱸") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr8(i, 1), "һ���") > 0 Or InStr(arr8(i, 1), "TERADATA") > 0 Or (InStr(arr7(i, 1), "���ػ�") > 0 And InStr(arr8(i, 1), "������") > 0) Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    End If
nt:
    Next
    
    If icount = 0 Then GoTo a1:
    Range("W2").Resize(UBound(brr), 1) = brr
    
    Range("X2").Value = icount
    
    Set rng = Range("A2:W" & rend)
    rng.Sort Range("W2"), order1:=xlDescending, Header:=xlNo
    
    arr = Range("A" & icount + 2 & ":V" & rend)
    
 '   Range("A2:W" & rend).ClearContents
 '   Range("A2").Resize(UBound(arr), UBound(arr, 2)) = arr
a1:
    Application.ScreenUpdating = True
    
    arr = Range("A1:W1")
    
    For i = 1 To 30
    If InStr(arr(1, i), "���ݿ�") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "DB"
    i = i + 1
    GoTo mt
    ElseIf InStr(arr(1, i), "����ϵͳ") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "OS"
    i = i + 1
    GoTo mt
    ElseIf InStr(arr(1, i), "�м��") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "MID"
    i = i + 1
    GoTo mt
    End If
mt:
    Next
    
    
End Sub




'��1�У�Ӧ�ýڵ����л��������������ֱ�; Rule_1 = Array("����һ", "�칫", "������֤", "Ͷ��׼��", "����������")

'Ӧ�ýڵ㱸��ģʽ��Ϊ�䱸;

'Ӧ�ýڵ��Ӧ�ýڵ��������ܰ��������ܻ����򡰼��ܷ���
'"����"
'Ӧ�ò�ΪCDS������ʽ�ĵ�������ECCOPT��ECC��ά�����նˣ���PEMS������������أ�-���Ӧ��û��
'("ECCOPT","BF-CDS(DCCB)","CDS"��
'��Դ����ϵͳ��Ӧ�������豸��С��Ϊ�����ػ����������ù������豸�����ķ�������Ϊ����������

'���ù������豸�����ķ�������Ϊ��һ�������Teradata��

'��Դ����ϵͳ��Ӧ�������豸��Ʒ��Ϊ��WDW�����ⵥλ��



