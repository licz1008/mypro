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

'delete多余列
colNames_del = Array("CI标识", "系统节点CI", "HostName", "DB实例名称", "中间件实例名称", "网络区域", "应用分类", "应用节点名称", "应用范围", "应用组", "应用状态", "灾备等级", "高可用参数", "高可用模式", "集群IP地址", "备份组关系", "备份组", "专业组", "应用维护部门", "应用维护人", "服务范围", "服务区域", "节点分组编号", "应用高可用模式", "资源编号", "序列号", "型号", "服务器CPU个数", "服务器CPU核数", "服务器内存容量", "服务器硬盘规格（G）", "物理位置", "安装机房", "分区编号", "设备分区CPU个数", "设备分区CPU核数", "设备分区内存容量", "设备分区内置硬盘个数", "设备分区RAID类型", "设备分区存储容量", "存储设备资源编号", "存储设备序列号", "HostGroupName", "存储资源容量", "VIP地址", "VIP域名", "CI负责机构", "CI负责人", "系统节点CI负责机构", "创建时间", "最后调整时间", "最后修改人", "维护来源", "备注", "配置项状态")

For i = 1 To 80
    For j = 0 To UBound(colNames_del)
        If Cells(1, i) = colNames_del(j) Then
            Columns(i).Delete
        End If
    Next
Next

'补齐空白IP
For i = 2 To 30000
    If Cells(i, 3) = "" Then
    Cells(i, 3) = Cells(i, 4).Value
    End If
Next


On Error Resume Next
    Application.ScreenUpdating = False
    Dim spcStr, arr, rend&, brr, rng As Range, icount&
    spcStr = Array("测试一", "办公", "生产验证", "投产准备", "生产待回收")
    rend = Range("A" & Rows.Count).End(xlUp).Row '最后一个非空行的行数
    arr = Range("A2:A" & rend) 'A列给arr
    Dim arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8, arr9 As Range
    arr1 = Range("J2:J" & rend) 'arr1，应用节点描述
    arr2 = Range("M2:M" & rend) 'arr2，品牌
    arr3 = Range("Q2:Q" & rend) 'arr3，系统节点CI负责部门
    arr4 = Range("N2:N" & rend) 'arr4，部署地
    arr5 = Range("H2:H" & rend) 'arr5，应用英文简称
    arr6 = Range("K2:K" & rend) 'arry6，主备类型
    arr7 = Range("L2:L" & rend) '小类
    arr8 = Range("O2:O" & rend) '分区类型
    ReDim brr(1 To UBound(arr), 1 To 1)  'brr(1-arr,1)，用来标记对应行是否包含关键字
    icount = 0
    For i = 1 To UBound(arr)    '第一行到最后一行循环
        For j = 0 To UBound(spcStr) '第一个关键字到最后一个关键字循环
            If InStr(arr(i, 1), spcStr(j)) > 0 Then   '匹配关键字
                brr(i, 1) = 1: icount = icount + 1
                GoTo nt
            End If
        Next
    If InStr(arr1(i, 1), "加密") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr2(i, 1), "WDW") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr3(i, 1), "数据中心（上海）系统四部") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr3(i, 1), "数据中心（上海）系统四部") = 0 And InStr(arr3(i, 1), "数据中心（上海）系统三部") = 0 And (InStr(arr4(i, 1), "外高桥") = 0 And InStr(arr4(i, 1), "嘉定") = 0) Then     '外高桥非系统3，4节点
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr5(i, 1), "ECCOPT") > 0 Or InStr(arr5(i, 1), "BF-CDS(DCCB)") > 0 Or (InStr(arr5(i, 1), "CDS") > 0 And InStr(arr5(i, 1), "F-CDSI") = 0) Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr6(i, 1), "冷备") > 0 Then
        brr(i, 1) = 1: icount = icount + 1
        GoTo nt
    ElseIf InStr(arr8(i, 1), "一体机") > 0 Or InStr(arr8(i, 1), "TERADATA") > 0 Or (InStr(arr7(i, 1), "工控机") > 0 And InStr(arr8(i, 1), "物理机") > 0) Then
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
    If InStr(arr(1, i), "数据库") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "DB"
    i = i + 1
    GoTo mt
    ElseIf InStr(arr(1, i), "操作系统") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "OS"
    i = i + 1
    GoTo mt
    ElseIf InStr(arr(1, i), "中间件") > 0 Then
    i = i + 1
    Columns(i).Insert
    Cells(1, i).Value = "MID"
    i = i + 1
    GoTo mt
    End If
mt:
    Next
    
    
End Sub




'第1列：应用节点运行环境属于生产、灾备; Rule_1 = Array("测试一", "办公", "生产验证", "投产准备", "生产待回收")

'应用节点备份模式不为冷备;

'应用节点的应用节点描述不能包含“加密机”或“加密服务”
'"加密"
'应用不为CDS（集中式文档机）、ECCOPT（ECC运维操作终端）、PEMS（机房环境监控）-这个应该没有
'("ECCOPT","BF-CDS(DCCB)","CDS"）
'资源管理系统中应服务器设备的小类为“工控机”，且配置管理中设备分区的分区类型为“物理机”

'配置管理中设备分区的分区类型为“一体机”或“Teradata”

'资源管理系统中应服务器设备的品牌为“WDW”（外单位）




