Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18C82D1869
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLGSUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:20:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:55724 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLGSUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:20:07 -0500
IronPort-SDR: lo6XuVK1zllT1PnO3OONmNo0Sw5/tcwieWa0tVwyKzHbJ4S1uIfKIOxATrfkY025MiHKfWYIZk
 R58hPt/crxvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173896498"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173896498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:15:39 -0800
IronPort-SDR: x5x4cUParmVdquYlNS0w4VNIzH4LHbVH9uGn8v9nPmS1slwFKZt/xx7cShIYp4ZjOyknSTBlNj
 3v2a8mIyU3Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="539892869"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2020 10:15:39 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] platform/x86: ISST: Change PCI device macros
Date:   Mon,  7 Dec 2020 10:15:31 -0800
Message-Id: <20201207181531.1718148-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
References: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PCI_VDEVICE and PCI_DEVICE_DATA macros. No functional changes are
expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../platform/x86/intel_speed_select_if/isst_if_common.h   | 8 ++++----
 .../platform/x86/intel_speed_select_if/isst_if_mbox_pci.c | 4 ++--
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 6 ++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
index 4f6f7f0761fc..fdecdae248d7 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
@@ -10,11 +10,11 @@
 #ifndef __ISST_IF_COMMON_H
 #define __ISST_IF_COMMON_H
 
-#define INTEL_RAPL_PRIO_DEVID_0	0x3451
-#define INTEL_CFG_MBOX_DEVID_0	0x3459
+#define PCI_DEVICE_ID_INTEL_RAPL_PRIO_DEVID_0	0x3451
+#define PCI_DEVICE_ID_INTEL_CFG_MBOX_DEVID_0	0x3459
 
-#define INTEL_RAPL_PRIO_DEVID_1 0x3251
-#define INTEL_CFG_MBOX_DEVID_1  0x3259
+#define PCI_DEVICE_ID_INTEL_RAPL_PRIO_DEVID_1	0x3251
+#define PCI_DEVICE_ID_INTEL_CFG_MBOX_DEVID_1	0x3259
 
 /*
  * Validate maximum commands in a single request.
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
index 95f01e7a87d5..a2a2d923e60c 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
@@ -146,8 +146,8 @@ static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
 }
 
 static const struct pci_device_id isst_if_mbox_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_0)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_1)},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CFG_MBOX_DEVID_0)},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CFG_MBOX_DEVID_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_mbox_ids);
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index 4c9020249989..ff49025ec085 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -82,10 +82,8 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 }
 
 static const struct pci_device_id isst_if_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0),
-		.driver_data = (kernel_ulong_t)&mmio_range_devid_0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1),
-		.driver_data = (kernel_ulong_t)&mmio_range_devid_1},
+	{ PCI_DEVICE_DATA(INTEL, RAPL_PRIO_DEVID_0, &mmio_range_devid_0)},
+	{ PCI_DEVICE_DATA(INTEL, RAPL_PRIO_DEVID_1, &mmio_range_devid_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_ids);
-- 
2.25.4

