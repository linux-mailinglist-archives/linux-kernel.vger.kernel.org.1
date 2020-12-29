Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6712A2E6D39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgL2CWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 21:22:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:61435 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgL2CWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 21:22:12 -0500
IronPort-SDR: WFuB7dVkneKz5TKG4lpaFqj40Uj1SbsDYQukyXEv96Gm+mkosjtSydFKWCFSNC0LRJvn69WiFV
 /+q1F6nPbXRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="175672159"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="175672159"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:21:31 -0800
IronPort-SDR: 6v1FP23WRj3IXNCDP4lNIB7ejLIBkLRjkk8ditc1hOeKz9lWBAyRsx2Pqea6dQ2Iqv+GDNA8J/
 y0sqf30B8iQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="419006047"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 28 Dec 2020 18:21:29 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v14 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Tue, 29 Dec 2020 10:16:42 +0800
Message-Id: <1609208208-6697-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main changes from v1:
- A new patch (Patch #3) to fix the description.
- Rename the dfl-bus.h to dfl.h
- Updated the MAINTAINERS under FPGA DFL DRIVERS.
- Improve comments and minor fixes.

Main changes from v2:
- Change the bus name from "dfl" to "fpga-dfl", also rename related
  variables, functions ...
- Changes the data type of fpga_dfl_device_id.type from u8 to u16
- Explicitly defines the values of enum fpga_dfl_id_type
- Delete the comments for the valid bits of type & feature_id
- changes MODALIAS format for fpga dfl devices

Main changes from v3:
- Change the bus name back to "dfl".
- Add 2 patches (#5, 6) for dfl drivers.
- Delete the retimer FEC mode configuration via module_parameter for
  Patch #5
- Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
  into Patch #5
- Add static prefix for emif attributes macro for Patch #6

Main changes from v9:
- Add the description for struct dfl_device_id in mod_devicetable.h
- Move the dfl.h from include/linux/fpga to include/linux
- some code refactor and minor fixes for dfl-n3000-nios

Main changes from v10:
- use sysfs_emit instead of sprintf for both patches
- rebase to 5.10-rc1

Main changes from v11:
- Fix the type of driver_data from unsigned long to kernel_ulong_t
- Fixed up header guards to match filename by Moritz
- move the MODULE_DEVICE_TABLE() right after its definition

Main changes from v12:
- For patch #5, fix the wrong use of logical'||', should use '|'

Main changes from v13:
- Rebase to 5.11-rc1

Xu Yilun (6):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
 MAINTAINERS                                        |   3 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fpga/dfl.h                                 |  85 +--
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 ++++++++
 include/linux/dfl.h                                |  86 +++
 include/linux/mod_devicetable.h                    |  24 +
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  13 +
 15 files changed, 1023 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c
 create mode 100644 include/linux/dfl.h

-- 
2.7.4

