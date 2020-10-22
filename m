Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CA295DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897698AbgJVL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:57:25 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:35248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2897691AbgJVL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:57:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 409FA18224D8E;
        Thu, 22 Oct 2020 11:57:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:41:152:355:379:599:960:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2194:2196:2197:2198:2199:2200:2201:2202:2393:2559:2562:2638:2902:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4384:4385:4395:5007:7875:8784:8957:9010:9038:9901:10004:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12740:12895:13161:13229:13894:13972:14096:14097:14659:21080:21221:21324:21433:21451:21627:21740:21939:21987:30030:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: apple16_6103b7f27250
X-Filterd-Recvd-Size: 13474
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 11:57:22 +0000 (UTC)
Message-ID: <9f35c30071230d15b13c1670dda7743d6702e2b5.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore ethtool CamelCase constants
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 22 Oct 2020 04:57:21 -0700
In-Reply-To: <20201022110113.3505-1-l.stelmach@samsung.com>
References: <CGME20201022110115eucas1p216072f5c30091771421c8c595242d3b9@eucas1p2.samsung.com>
         <20201022110113.3505-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 13:01 +0200, Łukasz Stelmach wrote:
> Ignore CamelCase constants describing Ethernet link parameters defined
> in include/uapi/linux/ethtool.h.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5295,6 +5295,10 @@ sub process {
>  #CamelCase
>  			if ($var !~ /^$Constant$/ &&
>  			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
> +#Ignore constants from include/uapi/linux/ethtool.h
> +			    $var !~ /^ETHTOOL_LINK_MODE_[0-9A-Za-z_]+_BIT$/ &&
> +			    $var !~ /^ADVERTISED_[0-9A-Za-z_]+$/ &&
> +			    $var !~ /^SUPPORTED_[0-9A-Za-z_]+$/ &&
>  #Ignore Page<foo> variants
>  			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
>  #Ignore SI style variants like nS, mV and dB

How about changing this to be a bit broader?

$var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/

There are 2 grep searches below:

First is in include/uapi/
Second is just drivers/

Finding the matches in include/uapi shows a
reasonable list, but run against all the .[ch] files
in the kernel shows over 7000 entries.

Maybe that's too large a list.

$ git grep -Poh '#\s*define\s+\b(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]\w*' include/uapi
#define DRM_MODE_CONNECTOR_Unknown
#define DRM_MODE_CONNECTOR_Composite
#define DRM_MODE_CONNECTOR_Component
#define DRM_MODE_CONNECTOR_DisplayPort
#define SUPPORTED_Autoneg
#define SUPPORTED_Pause
#define SUPPORTED_Asym_Pause
#define SUPPORTED_Backplane
#define ADVERTISED_Autoneg
#define ADVERTISED_Pause
#define ADVERTISED_Asym_Pause
#define ADVERTISED_Backplane
#define ARPOP_InREQUEST
#define ARPOP_InREPLY
#define K_HEXa
#define K_HEXb
#define K_HEXc
#define K_HEXd
#define K_HEXe
#define K_HEXf
#define MAX_DPs
#define RTMGRP_DECnet_IFADDR
#define RTMGRP_DECnet_ROUTE
#define RTNLGRP_DECnet_IFADDR
#define RTNLGRP_DECnet_ROUTE
#define RTNLGRP_DECnet_RULE
#define UART_RSA_IER_Rx_FIFO_H
#define UART_RSA_IER_Tx_FIFO_H
#define UART_RSA_IER_Tx_FIFO_E
#define UART_RSA_IER_Rx_TOUT
#define UART_RSA_SRR_Tx_FIFO_NEMP
#define UART_RSA_SRR_Tx_FIFO_NHFL
#define UART_RSA_SRR_Tx_FIFO_NFUL
#define UART_RSA_SRR_Rx_FIFO_NEMP
#define UART_RSA_SRR_Rx_FIFO_NHFL
#define UART_RSA_SRR_Rx_FIFO_NFUL
#define UART_RSA_SRR_Rx_TOUT
#define TCPF_CA_Open
#define TCPF_CA_Disorder
#define TCPF_CA_Recovery
#define TCPF_CA_Loss
#define VIRTIO_NET_RSS_HASH_TYPE_IPv4
#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4
#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4
#define VIRTIO_NET_RSS_HASH_TYPE_IPv6
#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6
#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6
#define VIRTIO_NET_HASH_REPORT_IPv4
#define VIRTIO_NET_HASH_REPORT_TCPv4
#define VIRTIO_NET_HASH_REPORT_UDPv4
#define VIRTIO_NET_HASH_REPORT_IPv6
#define VIRTIO_NET_HASH_REPORT_TCPv6
#define VIRTIO_NET_HASH_REPORT_UDPv6
#define VIRTIO_NET_HASH_REPORT_IPv6_EX
#define VIRTIO_NET_HASH_REPORT_TCPv6_EX
#define VIRTIO_NET_HASH_REPORT_UDPv6_EX

But run against drivers it's a huge list.
Maybe too big?
Here are the top used entries.
Take off the awk bits to see the entire list.

It seems about half of all the entries are for autogenerated,
never used names from drivers/gpu and drivers/staging

$ git grep -Poh '\b(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]\w+' -- drivers | \
  sort | uniq -c | awk '{if ($1 > 10) { print $0;}}'
     46 ADVERTISED_Asym_Pause
     90 ADVERTISED_Autoneg
     42 ADVERTISED_Pause
     11 AFU_Cntl
     11 AMPDU_Factor
     74 AS_Data
     77 AS_Host
     17 ASIC_Init
     36 ASIC_InternalSS_Info
     11 ATOM_PPLIB_CAC_Leakage_Table
     22 ATOM_PPLIB_Clock_Voltage_Dependency_Table
     11 ATOM_PPLIB_PPM_Table
     11 ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
     13 ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
     13 ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
     11 ATOM_PPLIB_VCE_State_Record
     12 ATOM_PPLIB_VCE_State_Table
     14 ATOM_Tonga_POWERPLAYTABLE
     13 ATOM_Vega10_POWERPLAYTABLE
     11 ATOM_Vega10_Voltage_Lookup_Table
     13 BP_Filter
     16 CCK_Diff
     16 CCK_Table_length
     11 CFGTBL_Trans_io_accel1
    450 CH_Ctrl
     15 CRT_Device
     22 DC_HPDx_INT_ACK
     12 DC_HPDx_INT_CONTROL
     37 DC_HPDx_INT_EN
     33 DC_HPDx_INT_POLARITY
     13 DC_HPDx_RX_INT_ACK
     19 DC_HPDx_RX_INT_EN
     12 DC_HPDx_SENSE
     34 DIG_Dynamic_MIN
     13 DIG_MaxOfMin
     27 DISPCLK_DPPCLK_Support
     13 DMA_Ctl
     34 DM_DigTable
     16 DM_EDCA_Table
     14 DM_FatTable
     57 DM_RxPathSelTable
     12 DM_Type_ByDriver
     22 DRM_MODE_CONNECTOR_Composite
     79 DRM_MODE_CONNECTOR_DisplayPort
     47 DRM_MODE_CONNECTOR_Unknown
     13 DRM_MODE_SUBCONNECTOR_Unknown
     11 DSP_HBridgeControl
     15 DSP_IsaSlaveControl
     14 DVI_Device
     11 EE_ChipSelect
     15 EFUSE_GetEfuseDefinition
     26 ETHTOOL_LINK_MODE_Asym_Pause_BIT
     24 ETHTOOL_LINK_MODE_Autoneg_BIT
     33 ETHTOOL_LINK_MODE_Pause_BIT
     13 F_Port
    137 FPT_BL_Card
     14 HPNA_NoiseFloor
     12 HW_Fsync
     15 IC_Cut
     18 IF_Mode
     14 IGI_Base
     11 IGI_LowerBound
     17 ISPCCDC_COLPTN_Gb_G
     17 ISPCCDC_COLPTN_Gr_Cy
     15 LCD_Device
     11 LIO_Target_ConfigFS
     20 LPS_Leave
     30 LVDS_InfoTable
     12 MDIO_ShiftClk
     11 M_Key
     11 MR_ArPdGet
     21 MR_LdRaidGet
     11 MR_PdDevHandleGet
     11 MR_TargetIdToLdGet
    121 MS_Lib
     21 MS_Status
     34 MT_AGG_ARxCR_LIMIT
    582 MXL_ControlWrite
     12 MXL_Ctrl
    221 MXL_SetGPIO
    333 NI_AI_ConvertClock
     30 NI_AI_ConvertClockTimebase
     17 NI_AI_ExternalMUXClock
     76 NI_AI_PauseTrigger
    377 NI_AI_ReferenceTrigger
    322 NI_AI_SampleClock
     46 NI_AI_SampleClockTimebase
    394 NI_AI_StartTrigger
    415 NI_AnalogComparisonEvent
    117 NI_AO_PauseTrigger
    344 NI_AO_SampleClock
     37 NI_AO_SampleClockTimebase
    326 NI_AO_StartTrigger
    352 NI_ChangeDetectionEvent
     37 NI_CtrA
    239 NI_CtrArmStartTrigger
     49 NI_CtrAux
     35 NI_CtrB
   1041 NI_CtrGate
   1338 NI_CtrInternalOutput
     77 NI_CtrOut
    207 NI_CtrSampleClock
   1101 NI_CtrSource
     78 NI_CtrZ
     15 NI_DI_InputBufferFull
     57 NI_DI_PauseTrigger
     15 NI_DI_ReadyForStartEvent
     15 NI_DI_ReadyForTransferEventBurst
     15 NI_DI_ReadyForTransferEventPipelined
     71 NI_DI_ReferenceTrigger
    249 NI_DI_SampleClock
     69 NI_DI_StartTrigger
     15 NI_DO_DataActiveEvent
     15 NI_DO_OutputBufferFull
     58 NI_DO_PauseTrigger
     15 NI_DO_ReadyForStartEvent
     15 NI_DO_ReadyForTransferEvent
    254 NI_DO_SampleClock
     72 NI_DO_StartTrigger
     17 NI_ExternalStrobe
    284 NI_FrequencyOutput
     56 NI_LogicHigh
    125 NI_LogicLow
     34 NI_MasterTimebase
     18 NI_SCXI_Trig1
     59 NI_WatchdogExpiredEvent
     12 NPHY_RfctrlIntc_override_TRSW
    156 N_Port
     19 NVKM_VMM_PAGE_Sxxx
     14 ODM_CfoTracking
     18 ODM_CmnInfoHook
     12 ODM_CmnInfoInit
     20 ODM_CmnInfoUpdate
     12 ODM_TXPowerTrackingCheck
     24 ODM_Write_DIG
     24 OFDM_Diff
     11 OPA_PortInfo
     12 PCI_Config
     13 PHM_PerformanceLevel
     14 PHM_PerformanceLevelDesignation
     27 PHM_PlatformCaps_AutomaticDCTransition
     11 PHM_PlatformCaps_BACO
     14 PHM_PlatformCaps_ClockStretcher
     17 PHM_PlatformCaps_DBRamping
     11 PHM_PlatformCaps_GCEDC
     49 PHM_PlatformCaps_MicrocodeFanControl
     22 PHM_PlatformCaps_PowerContainment
     11 PHM_PlatformCaps_PSM
     21 PHM_PlatformCaps_RegulatorHot
     19 PHM_PlatformCaps_SclkDeepSleep
     11 PHM_PlatformCaps_SclkThrottleLowNotification
     17 PHM_PlatformCaps_SQRamping
     21 PHM_PlatformCaps_StablePState
     17 PHM_PlatformCaps_TCPRamping
     17 PHM_PlatformCaps_TDRamping
     12 PHM_PlatformCaps_ThermalController
     13 PHM_PlatformCaps_UMDPState
     12 PHM_PlatformCaps_UVDDPM
     11 PHM_PlatformCaps_UVDPowerGating
     11 PHM_PlatformCaps_VCEPowerGating
    104 PHY_GetRateIndexOfTxPowerByRate
     34 PHY_GetTxPowerByRate
     19 PHY_GetTxPowerByRateBase
    108 PHY_QueryBBReg
     17 PHY_QueryRFReg
    295 PHY_SetBBReg
     87 PHY_SetRFReg
     12 PHY_SetTxPowerIndexByRateArray
     18 PHY_SetTxPowerIndexByRateSection
     39 P_Key
     16 P_Kin
     16 P_Kout
     12 POWER_SUPPLY_TECHNOLOGY_NiMH
     18 PP_BusCTL
     14 PP_Clocks
     16 PP_LineCTL
     15 PPM_PkgPwrLimit
     15 PPM_TemperatureLimit
     16 PP_SIslands_CacConfig
     12 PP_SIslands_DPM2Parameters
     14 PP_SIslands_PAPMParameters
     49 PPSMC_Msg
     15 PPSMC_MSG_DisableAllSmuFeatures
     12 PPSMC_MSG_DisableCac
     21 PPSMC_MSG_DisableClockGatingFeature
     12 PPSMC_MSG_DisableULV
     11 PPSMC_MSG_DPM_ForceState
     11 PPSMC_MSG_DramLogSetDramAddrHigh
     11 PPSMC_MSG_DramLogSetDramAddrLow
     11 PPSMC_MSG_DramLogSetDramSize
     15 PPSMC_MSG_EnableAllSmuFeatures
     12 PPSMC_MSG_EnableCac
     21 PPSMC_MSG_EnableClockGatingFeature
     12 PPSMC_MSG_EnableULV
     13 PPSMC_MSG_EnterBaco
     12 PPSMC_MSG_GetDpmFreqByIndex
     16 PPSMC_MSG_GetDriverIfVersion
     11 PPSMC_MSG_GetMaxDpmFreq
     17 PPSMC_MSG_GetSmuVersion
     11 PPSMC_MSG_MCLKDPM_FreezeLevel
     13 PPSMC_MSG_MCLKDPM_SetEnabledMask
     11 PPSMC_MSG_MCLKDPM_UnfreezeLevel
     14 PPSMC_MSG_NoForcedLevel
     13 PPSMC_MSG_NumOfDisplays
     12 PPSMC_MSG_PrepareMp1ForUnload
     13 PPSMC_MSG_SCLKDPM_FreezeLevel
     15 PPSMC_MSG_SCLKDPM_SetEnabledMask
     13 PPSMC_MSG_SCLKDPM_UnfreezeLevel
     29 PPSMC_MSG_SetDriverDramAddrHigh
     29 PPSMC_MSG_SetDriverDramAddrLow
     17 PPSMC_MSG_SetEnabledLevels
     14 PPSMC_MSG_SetForcedLevels
     17 PPSMC_MSG_SetHardMinByFreq
     14 PPSMC_MSG_SetHardMinFclkByFreq
     12 PPSMC_MSG_SetHardMinGfxClk
     11 PPSMC_MSG_SetHardMinSocclkByFreq
     13 PPSMC_MSG_SetMinDeepSleepDcefclk
     11 PPSMC_MSG_SetPptLimit
     13 PPSMC_MSG_SetSclkSoftMax
     13 PPSMC_MSG_SetSclkSoftMin
     21 PPSMC_MSG_SetSoftMaxByFreq
     11 PPSMC_MSG_SetSoftMaxFclkByFreq
     12 PPSMC_MSG_SetSoftMaxGfxClk
     22 PPSMC_MSG_SetSoftMinByFreq
     11 PPSMC_MSG_SetSystemVirtualDramAddrHigh
     11 PPSMC_MSG_SetSystemVirtualDramAddrLow
     12 PPSMC_MSG_SetToolsDramAddrHigh
     12 PPSMC_MSG_SetToolsDramAddrLow
     11 PPSMC_MSG_SetWorkloadMask
     11 PPSMC_MSG_SwitchToMinimumPower
     14 PPSMC_MSG_TestMessage
     23 PPSMC_MSG_TransferTableDram2Smu
     19 PPSMC_MSG_TransferTableSmu2Dram
     13 PPSMC_MSG_UVDDPM_SetEnabledMask
     13 PPSMC_MSG_VCEDPM_SetEnabledMask
     76 PPSMC_Result
     19 PPSMC_Result_Failed
    173 PPSMC_Result_OK
     13 PPSMC_Result_UnknownCmd
     11 PPSMC_StartFanControl
     13 PP_StateClassificationFlag_Boot
     29 PP_TemperatureRange
     34 PXI_Clk10
    123 PXI_Star
     14 QAM_Lock
     18 RES_Tx_P
     18 RF_Path
     20 RF_Type
     12 RGB_Scanlines
     12 RGB_Stride
     21 RSSI_Ave
     56 RSSI_Min
     29 SCC_Info
     11 SCR_RxDecEnable
     23 SD_Status
     12 SENSOR_POxxxx
     20 S_Info
     12 SMC_Evergreen_MCRegisters
     11 SMC_Evergreen_MCRegisterSet
     12 SMC_NIslands_MCRegisterAddress
     16 SMC_NIslands_MCRegisters
     11 SMC_NIslands_MCRegisterSet
     22 SMC_SIslands_MCArbDramTimingRegisterSet
     24 SMC_SIslands_MCRegisters
     14 SMC_SIslands_MCRegisterSet
     24 SMIO_Pattern
     20 SMIO_Table
     11 SMT_Unknown
     16 SMU_ClockStretcherDataTable
     16 SMU_ClockStretcherDataTableEntry
     24 SMU_QuadraticCoeffs
     14 SMU_SclkSetting
     20 SMU_SoftRegisters
     37 SMU_VoltageLevel
     12 SRB_DataOut
     27 SS_Info
     17 S_Status
     27 SUPPORTED_Asym_Pause
    104 SUPPORTED_Autoneg
     33 SUPPORTED_Pause
     12 SW_Fsync
     14 TDC_VDDC_PkgLimit
     28 TDC_VDDC_ThrottleReleaseLimitPerc
     14 TF_Type
     21 TM_Sn_STATUS_OFF
     19 TM_Trigger
     34 TUL_SCmd
     13 TUL_SCnt0
     12 TUL_SConfig
     20 TUL_SCtrl0
     55 TUL_SFifo
     24 TUL_SSignal
     45 TW_Command
     21 TW_Command_Apache_Header
     51 TW_Command_Full
    169 TW_Device_Extension
     22 TW_Event
     18 TW_Ioctl_Buf_Apache
     25 TW_Param
     25 TW_Sector
     18 TW_SG_Entry
     12 TW_SG_Entry_ISO
     23 UV_Scanlines
     19 UV_Stride
     15 UV_UBWC_Plane
     12 VBIOSSMC_Status_BUSY
     26 VB_NoLCD
     17 VM_ContainerConfig
     20 Y_Scanlines
     21 Y_Stride
     15 Y_UBWC_Plane


