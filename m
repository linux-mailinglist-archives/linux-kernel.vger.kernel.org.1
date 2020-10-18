Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231B291671
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgJRI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 04:28:11 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42227 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgJRI2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 04:28:10 -0400
Received: from [192.168.0.2] (ip5f5af1e8.dynamic.kabel-deutschland.de [95.90.241.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 80E152000C13E;
        Sun, 18 Oct 2020 10:28:07 +0200 (CEST)
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Intel PMC driver on Broadwell system to gather C-State statistics
Message-ID: <c0b7a8c4-6791-a5aa-b51e-61956a0928c1@molgen.mpg.de>
Date:   Sun, 18 Oct 2020 10:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


The Intel Broadwell-U laptop Dell Latitude E7250 (BIOS A19 01/23/2018), 
according to PowerTOP, only reaches package C-State C7 and not C8, C9, 
C10, while the four CPUs itself do reach C-State C10 and CE.

I was asked to look at:

1.  `/sys/kernel/debug/pmc_core/package_cstate_show`
2.  `/sys/kernel/debug/pmc_core/ltr`

Trying to gather statistics, after the Debian Linux kernel 5.9.1 is now 
built with `INTEL_PMC_CORE=y`, `/sys/kernel/debug/pmc_core/` is still 
not created despite `sudo modprobe intel_pmc_core` being successful. 
(It’s not loaded automatically.)

     [ 1063.644680] calling  pmc_core_driver_init+0x0/0x1000 
[intel_pmc_core] @ 4252
     [ 1063.644721] initcall pmc_core_driver_init+0x0/0x1000 
[intel_pmc_core] returned 0 after 36 usecs

The ACPI device `INT33A1` is there.

>     Scope (_SB)
>     {
>         Device (PEPD)         
>         {
>             Name (_HID, "INT33A1" /* Intel Power Engine */)  // _HID: Hardware ID
>             Name (_CID, EisaId ("PNP0D80") /* Windows-compatible System Power Management Controller */)  // _CID: Compatible ID
>             Name (_UID, One)  // _UID: Unique ID
>             Name (PEPP, Zero)
>             Name (DEVS, Package (0x03)
>             {        
>                 0x02, 
>                 Package (0x01)
>                 {
>                     "\\_SB.PCI0.GFX0"
>                 },    
>             
>                 Package (0x01)        
>                 {                           
>                     "\\_SB.PCI0.SAT0.PRT1"
>                 }
>             })
>             Name (DEVX, Package (0x08)

The table `intel_pmc_core_ids` does not contain the Broadwell-U ID 
though, so I guess it’s not supported.

> $ lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation Broadwell-U Host Bridge -OPI [8086:1604] (rev 09)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 5500 [8086:1616] (rev 09)
> 00:03.0 Audio device [0403]: Intel Corporation Broadwell-U Audio Controller [8086:160c] (rev 09)
> 00:04.0 Signal processing controller [1180]: Intel Corporation Broadwell-U Processor Thermal Subsystem [8086:1603] (rev 09)
> 00:14.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB xHCI Controller [8086:9cb1] (rev 03)
> 00:16.0 Communication controller [0780]: Intel Corporation Wildcat Point-LP MEI Controller #1 [8086:9cba] (rev 03)
> 00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection (3) I218-LM [8086:15a2] (rev 03)
> 00:1b.0 Audio device [0403]: Intel Corporation Wildcat Point-LP High Definition Audio Controller [8086:9ca0] (rev 03)
> 00:1c.0 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #1 [8086:9c90] (rev e3)
> 00:1c.3 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #4 [8086:9c96] (rev e3)
> 00:1d.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB EHCI Controller [8086:9ca6] (rev 03)
> 00:1f.0 ISA bridge [0601]: Intel Corporation Wildcat Point-LP LPC Controller [8086:9cc3] (rev 03)
> 00:1f.2 SATA controller [0106]: Intel Corporation Wildcat Point-LP SATA Controller [AHCI Mode] [8086:9c83] (rev 03)
> 00:1f.3 SMBus [0c05]: Intel Corporation Wildcat Point-LP SMBus Controller [8086:9ca2] (rev 03)
> 01:00.0 SD Host controller [0805]: O2 Micro, Inc. SD/MMC Card Reader Controller [1217:8520] (rev 01)
> 02:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a] (rev 59)

Any idea, why the probe function `pmc_core_probe()` succeeds, despite 
the code below?

         cpu_id = x86_match_cpu(intel_pmc_core_ids);
         if (!cpu_id)
                 return -ENODEV;

The watchdog driver iTCO_wdt seems to load the module `pmc_core_bxt` 
despite I am unable to find the ACPI device `INT34D2` in the dissembled 
AML/ASL files.


Kind regards,

Paul
