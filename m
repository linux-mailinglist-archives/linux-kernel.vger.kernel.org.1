Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9D2D1864
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLGSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:19:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:55894 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLGSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:19:11 -0500
IronPort-SDR: IPkccCymc3hgqKoDLCtpe0GLEG7RNLvYKEp2lPHPqDfAI2yNLgmKAiBFY7g2DtrQn7h9w6t2Wu
 qZbpOwhBZNlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173896496"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173896496"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:15:39 -0800
IronPort-SDR: byxTyghSog+5epm3G/whUHIFG1GesK+xIU7JJ3TfX77aLPKmEkOHbUwAezb44sMn/NjgxTIgis
 wFsol4s87LnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="539892868"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2020 10:15:39 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/3] platform/x86: ISST: Allow configurable offset range
Date:   Mon,  7 Dec 2020 10:15:30 -0800
Message-Id: <20201207181531.1718148-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
References: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmio offset range can be different based on the PCI device id. Here
for INTEL_RAPL_PRIO_DEVID_1, the range is increased from 45 to 64. Pass
the range as the driver_data. Also account for different ranges during
save/restore via suspend/resume callbacks.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
LKP test robot reported sparse warning. Added "Reported-by" as
suggested by the message.

 .../x86/intel_speed_select_if/isst_if_mmio.c  | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index e7e9808a1aed..4c9020249989 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -20,15 +20,21 @@ struct isst_mmio_range {
 	int end;
 };
 
-struct isst_mmio_range mmio_range[] = {
+static struct isst_mmio_range mmio_range_devid_0[] = {
 	{0x04, 0x14},
 	{0x20, 0xD0},
 };
 
+static struct isst_mmio_range mmio_range_devid_1[] = {
+	{0x04, 0x14},
+	{0x20, 0x11C},
+};
+
 struct isst_if_device {
 	void __iomem *punit_mmio;
 	u32 range_0[5];
-	u32 range_1[45];
+	u32 range_1[64];
+	struct isst_mmio_range *mmio_range;
 	struct mutex mutex;
 };
 
@@ -39,8 +45,6 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 	struct pci_dev *pdev;
 
 	io_reg = (struct isst_if_io_reg *)cmd_ptr;
-	if (io_reg->reg < 0x04 || io_reg->reg > 0xD0)
-		return -EINVAL;
 
 	if (io_reg->reg % 4)
 		return -EINVAL;
@@ -56,6 +60,10 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 	if (!punit_dev)
 		return -EINVAL;
 
+	if (io_reg->reg < punit_dev->mmio_range[0].beg ||
+	    io_reg->reg > punit_dev->mmio_range[1].end)
+		return -EINVAL;
+
 	/*
 	 * Ensure that operation is complete on a PCI device to avoid read
 	 * write race by using per PCI device mutex.
@@ -74,8 +82,10 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 }
 
 static const struct pci_device_id isst_if_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0),
+		.driver_data = (kernel_ulong_t)&mmio_range_devid_0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1),
+		.driver_data = (kernel_ulong_t)&mmio_range_devid_1},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_ids);
@@ -112,6 +122,7 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	mutex_init(&punit_dev->mutex);
 	pci_set_drvdata(pdev, punit_dev);
+	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.cmd_size = sizeof(struct isst_if_io_reg);
@@ -141,10 +152,15 @@ static int __maybe_unused isst_if_suspend(struct device *device)
 
 	for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
 		punit_dev->range_0[i] = readl(punit_dev->punit_mmio +
-						mmio_range[0].beg + 4 * i);
-	for (i = 0; i < ARRAY_SIZE(punit_dev->range_1); ++i)
-		punit_dev->range_1[i] = readl(punit_dev->punit_mmio +
-						mmio_range[1].beg + 4 * i);
+						punit_dev->mmio_range[0].beg + 4 * i);
+	for (i = 0; i < ARRAY_SIZE(punit_dev->range_1); ++i) {
+		u32 addr;
+
+		addr = punit_dev->mmio_range[1].beg + 4 * i;
+		if (addr > punit_dev->mmio_range[1].end)
+			break;
+		punit_dev->range_1[i] = readl(punit_dev->punit_mmio + addr);
+	}
 
 	return 0;
 }
@@ -156,10 +172,16 @@ static int __maybe_unused isst_if_resume(struct device *device)
 
 	for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
 		writel(punit_dev->range_0[i], punit_dev->punit_mmio +
-						mmio_range[0].beg + 4 * i);
-	for (i = 0; i < ARRAY_SIZE(punit_dev->range_1); ++i)
-		writel(punit_dev->range_1[i], punit_dev->punit_mmio +
-						mmio_range[1].beg + 4 * i);
+						punit_dev->mmio_range[0].beg + 4 * i);
+	for (i = 0; i < ARRAY_SIZE(punit_dev->range_1); ++i) {
+		u32 addr;
+
+		addr = punit_dev->mmio_range[1].beg + 4 * i;
+		if (addr > punit_dev->mmio_range[1].end)
+			break;
+
+		writel(punit_dev->range_1[i], punit_dev->punit_mmio + addr);
+	}
 
 	return 0;
 }
-- 
2.25.4

