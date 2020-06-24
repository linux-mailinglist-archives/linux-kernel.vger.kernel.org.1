Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663D4207ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405832AbgFXRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 13:51:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:13102 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405615AbgFXRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:51:54 -0400
IronPort-SDR: MmgDRT96SNo8OF812dgKMJUE4HyGNjEItvKlCnar78OlyLzEt+YRac6DrHKtH2RthRYcrrs0Bv
 Yis6E8KJ86FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143681609"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="143681609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 10:51:53 -0700
IronPort-SDR: vVhEFjpJemP1joTx2o7ekm1G0f0OcUxqJ41KgJIu1L0UZ2lfLrVkMbTMPcQFv/wffoHbMHCWMx
 iU8LzwaSdw7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="292693089"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2020 10:51:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Add new PCI device ids
Date:   Wed, 24 Jun 2020 10:51:38 -0700
Message-Id: <20200624175138.3835436-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new PCI device ids for supporting mailbox and MMIO interface for
Sapphire Rapids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_common.h   | 3 +++
 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c | 1 +
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
index 1409a5bb5582..4f6f7f0761fc 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
@@ -13,6 +13,9 @@
 #define INTEL_RAPL_PRIO_DEVID_0	0x3451
 #define INTEL_CFG_MBOX_DEVID_0	0x3459
 
+#define INTEL_RAPL_PRIO_DEVID_1 0x3251
+#define INTEL_CFG_MBOX_DEVID_1  0x3259
+
 /*
  * Validate maximum commands in a single request.
  * This is enough to handle command to every core in one ioctl, or all
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
index d84e2174cbde..95f01e7a87d5 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
@@ -147,6 +147,7 @@ static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
 
 static const struct pci_device_id isst_if_mbox_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_0)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_mbox_ids);
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index 3584859fcc42..aa17fd7817f8 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -72,6 +72,7 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 
 static const struct pci_device_id isst_if_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_ids);
-- 
2.25.4

