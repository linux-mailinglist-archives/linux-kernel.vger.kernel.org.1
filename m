Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C308F2CE57D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgLDCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:01:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:63654 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgLDCBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:01:19 -0500
IronPort-SDR: 6UUDBMHTSfzRMKdgGt8EFrJUmwXRMeLpG+gq+DCC13kX2Ows4+8df/b1/Oi8kn0egTo58o9SSU
 CWy3oz4vp0lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170745351"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="170745351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:57:58 -0800
IronPort-SDR: svlpgVnlrMW0SZdjk+sQAW3MZi5QXvapaFhzWEd3I0Ni0eYKgS8noFxyYrQA4x1tu+w9lVyWSv
 C1M/ECR6z2Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="331053756"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2020 17:57:57 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] platform/x86: ISST: Allow configurable offset range
Date:   Thu,  3 Dec 2020 17:57:45 -0800
Message-Id: <20201204015746.1168941-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
References: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmio offset range can be different based on the PCI device id. Here
for INTEL_RAPL_PRIO_DEVID_1, the range is increased from 45 to 64. Pass
the range as the driver_data. Also account for different ranges during
save/restore via suspend/resume callbacks.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel_speed_select_if/isst_if_mmio.c  | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index e7e9808a1aed..c4bf8dea32ca 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -20,15 +20,21 @@ struct isst_mmio_range {
 	int end;
 };
 
-struct isst_mmio_range mmio_range[] = {
+struct isst_mmio_range mmio_range_devid_0[] = {
 	{0x04, 0x14},
 	{0x20, 0xD0},
 };
 
+struct isst_mmio_range mmio_range_devid_1[] = {
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

