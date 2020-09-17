Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE526D579
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIQIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:00:09 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:12410 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIQH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:59:45 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:59:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600329584; x=1631865584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=soGW+pknjaksN08RJ7LPk0ndAYp4pwodv9WM2rL7awQ=;
  b=xH84vWDsBMerjf4jlpJQplhyPcyh42/sziUXFknvrneZBlz4bRpCPqph
   ceYbBIf/u1wvC1usP2dsYyJo8J90NR5ykEQM0sSRHHgUvxxGAH8j2xABc
   aQ452PrrEUPReUjAW3y0Lnt/ObEM5PbfOAnl4SUFbMI8wKf9Orrd6zWmn
   3UCHLWPCdB/ENKEBPafCD16w4glXmJnxmr6HoFT/gF4hehSxEbsH+J3Zu
   B+pypYBjX5vblT1bng5mIY1MEOn09quRF26m2MNN5wNzzwj/3QCJAgWy5
   DR+ebQGXvfmdj+SkQuO38xEDQqcXAVmfROlVC1jUI4ABjFVw9u/tzFdPZ
   w==;
IronPort-SDR: aQjr5gh0DdIuLQSBqrioZhf/IlVjfM2bc7tzY7wh5eIXW/WLU3XtGnxxUedOv4W8W8AR6/Lycm
 v4dbgfEldFXsybFqTNPSRj/XZC1Ie2LRirq3d1Dc5f1O5NQoSaLyXVrLddLeXHNDVSmZ0vZ6WO
 uyOkaGqkGCl0/9eteH/aw6VT111LLcO4d6hCMGIOwuZIBbzzjc7tovBfIOUBSTt9jpCrTOralY
 Ytn/4KdEFMwWkXhMOkgx7/XmFCHC73hs7SxqTXk4O1QK117/ZZ3PCb0EFYcqd0jBgqk1NEG8da
 wFc=
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="91346697"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2020 00:52:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 00:51:56 -0700
Received: from atudor-ThinkPad-T470p.local (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 17 Sep 2020 00:51:54 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/3] mtd: rawnand: Fix HW ECC handling
Date:   Thu, 17 Sep 2020 10:52:10 +0300
Message-ID: <20200917075213.532161-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a wrongful fallthrough NAND_ECC_SOFT when a valid HW ECC is
available. Follow with two patches to make the code more readable.

Following error was seen in case of a valid HW ECC:
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
nand: Micron MT29F2G08ABAEAWP
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/mtd/nand/raw/nand_base.c:5148 nand_scan_with_ids+0x12b8/0x1674
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc5-next-20200914 #2
Hardware name: Atmel SAMA5
[<c010c1e0>] (unwind_backtrace) from [<c0109aac>] (show_stack+0x10/0x14)
[<c0109aac>] (show_stack) from [<c07e9380>] (__warn+0xb8/0xd0)
[<c07e9380>] (__warn) from [<c07e93f8>] (warn_slowpath_fmt+0x60/0xbc)
[<c07e93f8>] (warn_slowpath_fmt) from [<c04cbc84>] (nand_scan_with_ids+0x12b8/0x1674)
[<c04cbc84>] (nand_scan_with_ids) from [<c04d32e0>] (atmel_nand_controller_add_nand+0x54/0x100)
[<c04d32e0>] (atmel_nand_controller_add_nand) from [<c04d36a8>] (atmel_nand_controller_add_nands+0x31c/0x60c)
[<c04d36a8>] (atmel_nand_controller_add_nands) from [<c04d55c0>] (atmel_hsmc_nand_controller_probe+0x188/0x284)
[<c04d55c0>] (atmel_hsmc_nand_controller_probe) from [<c04d40ec>] (atmel_nand_controller_probe+0x54/0x134)
[<c04d40ec>] (atmel_nand_controller_probe) from [<c047ef2c>] (platform_drv_probe+0x48/0x98)
[<c047ef2c>] (platform_drv_probe) from [<c047cfd0>] (really_probe+0x1e0/0x3b8)
[<c047cfd0>] (really_probe) from [<c047d310>] (driver_probe_device+0x5c/0xb4)
[<c047d310>] (driver_probe_device) from [<c047b3c0>] (bus_for_each_drv+0x80/0xc4)
[<c047b3c0>] (bus_for_each_drv) from [<c047cd7c>] (__device_attach+0xe0/0x14c)
[<c047cd7c>] (__device_attach) from [<c047c064>] (bus_probe_device+0x84/0x8c)
[<c047c064>] (bus_probe_device) from [<c04790bc>] (device_add+0x408/0x774)
[<c04790bc>] (device_add) from [<c05d742c>] (of_platform_device_create_pdata+0x98/0xd4)
[<c05d742c>] (of_platform_device_create_pdata) from [<c05d7604>] (of_platform_bus_create+0x190/0x220)
[<c05d7604>] (of_platform_bus_create) from [<c05d77c8>] (of_platform_populate+0x60/0xc0)
[<c05d77c8>] (of_platform_populate) from [<c05dd6e4>] (atmel_ebi_probe+0x358/0x530)
[<c05dd6e4>] (atmel_ebi_probe) from [<c047ef2c>] (platform_drv_probe+0x48/0x98)
[<c047ef2c>] (platform_drv_probe) from [<c047cfd0>] (really_probe+0x1e0/0x3b8)
[<c047cfd0>] (really_probe) from [<c047d310>] (driver_probe_device+0x5c/0xb4)
[<c047d310>] (driver_probe_device) from [<c047d508>] (device_driver_attach+0x58/0x60)
[<c047d508>] (device_driver_attach) from [<c047d568>] (__driver_attach+0x58/0xcc)
[<c047d568>] (__driver_attach) from [<c047b2ec>] (bus_for_each_dev+0x74/0xb4)
[<c047b2ec>] (bus_for_each_dev) from [<c047c258>] (bus_add_driver+0xf4/0x1d8)
[<c047c258>] (bus_add_driver) from [<c047dd88>] (driver_register+0x74/0x108)
[<c047dd88>] (driver_register) from [<c047f33c>] (__platform_driver_probe+0x68/0xc8)
[<c047f33c>] (__platform_driver_probe) from [<c01016d0>] (do_one_initcall+0x7c/0x1cc)
[<c01016d0>] (do_one_initcall) from [<c0b00f78>] (kernel_init_freeable+0x15c/0x1c0)
[<c0b00f78>] (kernel_init_freeable) from [<c07f23a4>] (kernel_init+0x8/0x114)
[<c07f23a4>] (kernel_init) from [<c0100148>] (ret_from_fork+0x14/0x2c)
Exception stack(0xcf427fb0 to 0xcf427ff8)
7fa0:                                     00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 7fad321bf58a54e1 ]---
atmel-nand-controller 10000000.ebi:nand-controller: NAND scan failed: -22
atmel-nand-controller: probe of 10000000.ebi:nand-controller failed with error -22

Tudor Ambarus (3):
  mtd: rawnand: Fix wrongful fallthrough NAND_ECC_SOFT
  mtd: rawnand: Introduce nand_set_ecc_on_host_ops()
  mtd: rawnand: Don't overwrite the error code from
    nand_set_ecc_soft_ops()

 drivers/mtd/nand/raw/nand_base.c | 134 ++++++++++++++++---------------
 1 file changed, 70 insertions(+), 64 deletions(-)

-- 
2.25.1

