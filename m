Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D472CE57A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLDCAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:00:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:63510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLDCAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:00:53 -0500
IronPort-SDR: wqWFzC+ua0sg7QexOOFVnWbKWAR+kbnTelc1VzEt6QCU+qaNRNFe9tV4L7i7YM1qOsb8BrYt76
 VlU20Lh15W1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170745350"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="170745350"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:57:58 -0800
IronPort-SDR: zW4iQQqtMalF1xbouHLefHqqTSEVDJHOv7nrXaPT2Y6qfu0aaFKbfDqAZRtKIbWz30eeoCzWAY
 L1A60KguthZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="331053757"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2020 17:57:57 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] platform/x86: ISST: Change PCI device macros
Date:   Thu,  3 Dec 2020 17:57:46 -0800
Message-Id: <20201204015746.1168941-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
References: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
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
index c4bf8dea32ca..2906cfee5d9c 100644
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

